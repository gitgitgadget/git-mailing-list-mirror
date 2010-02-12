From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v4 1/2] git-imap-send: Add CRAM-MD5 authenticate method 
	support
Date: Fri, 12 Feb 2010 13:41:07 +0100
Message-ID: <40aa078e1002120441p2240797du7481c8da21e6176b@mail.gmail.com>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:41:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfupf-0007OU-V2
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab0BLMlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 07:41:11 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:65055 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab0BLMlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2010 07:41:09 -0500
Received: by ewy28 with SMTP id 28so1247689ewy.28
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=p3qh02dWcBR5jjTb7LiAblJ4p+SFcSDPQBIyqV6VwKo=;
        b=W3rYqZMOZQqH9pGJe/0B5ZRh4sHvkJ9JxZP5LXEbuPgrsEqHRZ25iE3CbuyvQeHVZ8
         LKo45Jeb6Br4KvBoKVMICBiEJdNoZkdIXZg64Pfqr/UI1sGJiily4C7eQaQVTpwXzxtN
         GN0pKHXCBUYysestnhVl2EPROoHah/VirHBEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=aa7SE06g0LrS+ffla5u2pXgKMnjHxG13/ZghDxbgwC69BsCKUMxg7ylmKn4oFuMEde
         EZtLoAPDQF7SQEzD6Vo5yRpXc97IiScwWph+kappomQ/ugCbixfns5KC/27uP+h74Y6s
         ZoBFaEWrDpV594jiPdSLdvTVz3z1k2K1bZdqo=
Received: by 10.216.90.74 with SMTP id d52mr828938wef.51.1265978467593; Fri, 
	12 Feb 2010 04:41:07 -0800 (PST)
In-Reply-To: <1265974572-6282-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139698>

On Fri, Feb 12, 2010 at 12:36 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> +
> +static char *cram(const char *challenge_64, const char *user, const =
char *pass)
> +{
> + =A0 =A0 =A0 fprintf(stderr, "If you want to use CRAM-MD5 authentica=
te method,"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "you have to build git-imap-send with O=
penSSL library\n");
> + =A0 =A0 =A0 exit(1);
> +}
> +

Why not use die() here?

--=20
Erik "kusma" Faye-Lund
