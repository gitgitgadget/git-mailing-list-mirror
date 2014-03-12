From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 10:06:10 -0400
Message-ID: <CALs4jVFM58Yiku4B8NrVeac0Hmt5YsPNYb_EjY6bOr=JO6pP+A@mail.gmail.com>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com> <CACsJy8DUhqn_ESzT-KpAdrWvWcLbPUiXDmBZXu7UtHU+M0GLgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 15:06:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNjno-0005St-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 15:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbaCLOGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 10:06:32 -0400
Received: from mail-wg0-f68.google.com ([74.125.82.68]:54465 "EHLO
	mail-wg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbaCLOGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 10:06:31 -0400
Received: by mail-wg0-f68.google.com with SMTP id m15so2441635wgh.7
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EEm1pgDPET+GiDFWlI7GsBQmVA5L3v8yiL2wbcp84to=;
        b=lRDUfdblKpOzKXKR5qb9M3MQwjmUl/Fc135GjD3Z+T/xSDS6PniEsg3Vy3OSxP+B0F
         8x413GR/zVWO+zSa5oyVWgtBAVT4v6GnjUSW4RqHzkQxrMEZdbAOoiYBI5xApFyfigCu
         7uljUIInv0ahCi8gM5aOv9OCea06im64DWH8sG5qyuoxkp5YMhTnNUKXbvDL9V1gNxPb
         a7rYKIBvY0PvlLDf2tGyTGs/cA+J3FrflX9OWa/HBFlkn/otWKRdWPKdf8OENRWrEgh+
         5DJsy11SpfXVhRdA/tN9th5N/f9C5PxrMFKhMuucYrjbNd4QNDlZBHyxz2Z5mM9o7Es7
         kmzg==
X-Received: by 10.180.25.46 with SMTP id z14mr7659472wif.49.1394633190442;
 Wed, 12 Mar 2014 07:06:30 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Wed, 12 Mar 2014 07:06:10 -0700 (PDT)
In-Reply-To: <CACsJy8DUhqn_ESzT-KpAdrWvWcLbPUiXDmBZXu7UtHU+M0GLgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243939>

2014-03-12 9:51 GMT-04:00 Duy Nguyen <pclouds@gmail.com>:
> starts_with(..) == !memcmp(...). So
> you need to negate every replacement.

My apologies--it doesn't look like the tests caught it either. I will
fix this and submit a new patch.
