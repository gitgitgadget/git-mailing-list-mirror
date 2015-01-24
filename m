From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 20/24] update-index: test the system before enabling
 untracked cache
Date: Sat, 24 Jan 2015 09:51:30 +0700
Message-ID: <CACsJy8C+eP15EnHfVkyjLkq7+XpPEOEJ9nnr2H41kPg8SywL2Q@mail.gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
 <1421759013-8494-21-git-send-email-pclouds@gmail.com> <xmqqwq4gy1nq.fsf@gitster.dls.corp.google.com>
 <CACsJy8CDgUWEE=QKAgw4G8pgA-cOmLMs4sH67C47Ohd5XJQDNQ@mail.gmail.com>
 <xmqqvbk0vug9.fsf@gitster.dls.corp.google.com> <20150122102624.GA25892@lanh> <xmqqfvb2tzvb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 03:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEqpX-0008MQ-0m
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 03:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbbAXCwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 21:52:03 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:51421 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbAXCwB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 21:52:01 -0500
Received: by mail-qg0-f45.google.com with SMTP id q107so630037qgd.4
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 18:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qAwgGZ610NNvvezaDfCcKZOFA8Uq+M5R/3jrMqPAZ2o=;
        b=a9iuaFvhUzgPduwsnOoXjVMlegh7Kiwophq9g61yRNzmgZhmkplgyBKrkjuRLP+CN0
         ob9jU9VAuNY9D6fLE/UR6r8S0l3Z0HAZjSDhMqwWsZzL6VEkvHpf7xiISOlc9Mtwkmtn
         by91VEPMrTW6gLBw/EJ3kmsx2q1KVQEG0vSTysELHK/kej3AnhHz81nc6lLDsBm78Rib
         wzTZsgAwI2pHBPLRZIl3QEwE33wTe0qam9UgQ0v8v6RhmG6M0TLUpjutxRGKo29kba8e
         YmRUb0K1qWZ7kegjfhAoBDoUoH0mheLlffH146D+CrqGPSNhQbe1Qf5k4vFk1WJTyQ4k
         e5Iw==
X-Received: by 10.140.35.114 with SMTP id m105mr19625983qgm.79.1422067920930;
 Fri, 23 Jan 2015 18:52:00 -0800 (PST)
Received: by 10.96.137.73 with HTTP; Fri, 23 Jan 2015 18:51:30 -0800 (PST)
In-Reply-To: <xmqqfvb2tzvb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262986>

On Fri, Jan 23, 2015 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I am not (yet) enthused by the intrusiveness of the overall series, though.

I think the gain justifies the series' complexity. Although I don't
mind redoing the whole series if we find a better way.
-- 
Duy
