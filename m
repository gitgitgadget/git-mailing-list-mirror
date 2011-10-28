From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 01/11] Introduce "check-attr --excluded" as a
 replacement for "add --ignore-missing"
Date: Sat, 29 Oct 2011 07:51:15 +1100
Message-ID: <CACsJy8BS_XgNWhWG+dsnMYLGUYTd_MODdhonbLAXtJw2Fe--Zw@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-2-git-send-email-pclouds@gmail.com> <7vfwiez4s5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 22:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJtP6-0001uK-Do
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 22:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226Ab1J1Uvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 16:51:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38732 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754Ab1J1Uvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 16:51:47 -0400
Received: by bkbzt4 with SMTP id zt4so781013bkb.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 13:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lX7UBHbUJthVP3uSVPROgd3s8jkjSUkDRtsVMU+L/0E=;
        b=H5Mt4KLYf/PgFnLNO1gEcAa+lEcV8bYfKF/7vPo/qwc4YzkIY+wKvTQOz0QRbY7AEu
         2eq55JPcb3oNSoqz1WIHMt4aPVhm2DvVXAavA0yalirzttURFE8YhBX0rRbeDb7oGY5p
         y2PM5MqKKQsWfmt7FvabwIIy0Q85wUSyVHJqU=
Received: by 10.204.26.214 with SMTP id f22mr3716833bkc.19.1319835106118; Fri,
 28 Oct 2011 13:51:46 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Fri, 28 Oct 2011 13:51:15 -0700 (PDT)
In-Reply-To: <7vfwiez4s5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184433>

2011/10/28 Junio C Hamano <gitster@pobox.com>:
> Perhaps ls-files is a more suitable home for the feature?

ls-files sounds good. It does all kinds of file selection already.
I'll see if I can add -I (aka "show ignored files only) to it.
-- 
Duy
