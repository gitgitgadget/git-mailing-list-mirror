From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not allowed
Date: Thu, 13 Oct 2011 18:02:13 +1100
Message-ID: <CACsJy8Dc_=kLtK28VVsOJgwgqAgsmkXrr0s3jR4fno_N-WiqUw@mail.gmail.com>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org> <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net> <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013055924.GA24019@elie.hsd1.il.comcast.net> <CACsJy8C6o_-SM4oCM6o5-VDXFy5PBXsE0oL_uhYH1_Zk9h06QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 09:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REFJZ-0002Ol-4O
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 09:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1JMHCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 03:02:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab1JMHCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 03:02:43 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so1038389bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7OyHWl7GwFYD+z+SglYsgTWmcBwcPtOcX72aGOmOmqI=;
        b=HaAXTNvdZQpL6bjPHckPu8gy05MMnCgls2hp7XTbJdEm7RZ+FIh8pz1JX/RgbQuL+z
         TzG2BSVa5OqwbOy9qgXetXdn+WM40KLXD7HSWCwsqnNDhCx9Kfl1JqnmrZVt81osmvLM
         7WXhgTNvTMDmTOvmDKPeeoaFQMMF0SjIu/5eM=
Received: by 10.204.10.67 with SMTP id o3mr1649458bko.3.1318489363119; Thu, 13
 Oct 2011 00:02:43 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Thu, 13 Oct 2011 00:02:13 -0700 (PDT)
In-Reply-To: <CACsJy8C6o_-SM4oCM6o5-VDXFy5PBXsE0oL_uhYH1_Zk9h06QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183445>

On Thu, Oct 13, 2011 at 5:56 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Translation could be fun to do

By translation, I don't mean inter-language translation. More like
personification. Instead of "service not enabled" you may want
"service is off, you want to attack me or what?"
-- 
Duy
