From: Nikolaus Rath <Nikolaus@rath.org>
Subject: Advanced revision selection?
Date: Fri, 27 May 2016 08:39:32 -0700
Message-ID: <874m9j7bnv.fsf@thinkpad.rath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 17:48:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Jzf-0000WG-Bc
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 17:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbcE0PsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 11:48:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32837 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752880AbcE0PsG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 11:48:06 -0400
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 May 2016 11:48:06 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 23011201B3
	for <git@vger.kernel.org>; Fri, 27 May 2016 11:39:34 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 27 May 2016 11:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=RO3PsOeGS1p4Dgbqcd0TI6FLMlg=; b=hP+Li
	fdVsI7C/+4XGZlQ2VMGBFgyhHSaQU9ocuc+UYO+vFG4PRGDy0OJtwdHH9W5oBA50
	PupxteFr3zVi1XBeul7vae2X/sQLCtlS/+d/zlDkMM7rAypTTiDFv0meXnZUxH6x
	lt1Grx3u3hcRGAsxUY1jf3r4258LYApsM21koE=
X-Sasl-enc: UUBRhXzGdip6vCAmj218v/q+N/gzQCi5dZyq0Ecf9q5S 1464363573
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id D2A8CF2A4D
	for <git@vger.kernel.org>; Fri, 27 May 2016 11:39:33 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 97A8D2C6FB3
	for <git@vger.kernel.org>; Fri, 27 May 2016 15:39:32 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id B6327C0D75; Fri, 27 May 2016 08:39:32 -0700 (PDT)
Mail-Copies-To: never
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295763>

Hello,

Is there a way to specify revision ranges that has more power than
what's described in gitrevisions(7)?

=46or example, is there a way to show "the three most recent commits
preceding a tag that starts with "release-" that are also descendants o=
f
commit aebecf."?

In Mercurial, this can be done with a more verbose syntax (e.g.
"last(ancestors(tag("re:release-.*")),3) and descendants(aebeccf)" for
the above example). Is there no equivalent in Git, or am I looking for
it in the wrong place?

Best,
-Nikolaus

--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
=46ingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
