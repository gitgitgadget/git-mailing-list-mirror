From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH v2 3/3] remote-helpers: export GIT_DIR variable to helpers
Date: Thu, 14 Jul 2011 00:10:40 +0600
Message-ID: <CA+gfSn9QeK84xVWrxYBGOwfWbeuS7cU_=D10Lrn8S__iygx+mg@mail.gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
	<1310577055-6347-3-git-send-email-divanorama@gmail.com>
	<CAGdFq_gAyjz+WCpK5qW7xcyGxSx4gg-A7Ju-AaHQ2o9mM_=pvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 20:10:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh3tW-00063l-Vm
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 20:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757193Ab1GMSKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 14:10:42 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42902 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab1GMSKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 14:10:41 -0400
Received: by qyk29 with SMTP id 29so449762qyk.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=os6ItbgodiY3AcJ4o5FvdJHaqypMCvyYlOVAp4PJMAs=;
        b=BeguD5ZbpSF7Rp8AY/k2XIoySpheN2hh9xbHCTdlbnAVSTjbmBaAiralwSGLbShaxC
         00ikgoZ+8gdyJmVYN8Zl7prucdnnpbd8DT8htZ1hZrnTGnmLGyEGf6VBL7sdLQ/MLSho
         j8D62RY8ZY2W6jL8vqDjV0hiBIRl4CmUKo00Q=
Received: by 10.224.185.72 with SMTP id cn8mr1294577qab.108.1310580640398;
 Wed, 13 Jul 2011 11:10:40 -0700 (PDT)
Received: by 10.229.63.232 with HTTP; Wed, 13 Jul 2011 11:10:40 -0700 (PDT)
In-Reply-To: <CAGdFq_gAyjz+WCpK5qW7xcyGxSx4gg-A7Ju-AaHQ2o9mM_=pvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177067>

Hi!

On Wed, Jul 13, 2011 at 11:36 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Wed, Jul 13, 2011 at 19:10, Dmitry Ivankov <divanorama@gmail.com> wrote:
>> Instead of documenting capability gitdir export GIT_DIR. Turned out
>> to be quite straightforward.
>
> But you _also_ documented the gitdir capability? I'm confused.
Oww, it was a bad idea to amend previous commit in a hurry and not to
read the whole diff after.
Of course Documentation/git-remote-helpers.txt should have only a GIT_DIR hunk:

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 58f6ad4..feda03e 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -47,6 +47,9 @@ arguments. The first argument specifies a remote
repository as in git;
 it is either the name of a configured remote or a URL. The second
 argument specifies a URL; it is usually of the form
 '<transport>://<address>', but any arbitrary string is possible.
+'GIT_DIR' environment variable is set up for the remote helper and
+can be used to store some additional data or to invoke auxiliary git
+commands.

 When git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it



>
> --
> Cheers,
>
> Sverre Rabbelier
>
