From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH] Documentation/git-tag.txt: Document how to backdate tags
Date: Mon, 15 Oct 2007 13:51:30 -0400
Message-ID: <87lka4cllp.fsf@hariken.mwolson.org>
References: <87bqbklu5r.fsf@hariken.mwolson.org>
	<871wcglqrg.fsf@hariken.mwolson.org>
	<7vps00ivgh.fsf@gitster.siamese.dyndns.org>
	<87hclck6qy.fsf@hariken.mwolson.org>
	<7vd4w0iqd5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 21:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhV2F-000489-AV
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 20:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935175AbXJOSvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935171AbXJOSvH
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 14:51:07 -0400
Received: from mailhub249.itcs.purdue.edu ([128.210.5.249]:50937 "EHLO
	mailhub249.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935138AbXJOSvE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 14:51:04 -0400
Received: from ip6-localhost (host-212-116.inlacol.clients.pavlovmedia.com [66.253.212.116])
	(authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.13.7/8.13.7/auth-smtp.purdue.edu) with ESMTP id l9FHpUhM006432
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT);
	Mon, 15 Oct 2007 13:51:49 -0400
Received: from mwolson by ip6-localhost with local (Exim 4.67)
	(envelope-from <mwolson@hariken.mwolson.org>)
	id 1IhU6E-00040X-2v; Mon, 15 Oct 2007 13:51:30 -0400
X-Hashcash: 1:20:071015:git@vger.kernel.org::+cY+KOJtOJPJoQsX:0000000000000000000000000000000000000000001XxG
In-Reply-To: <7vd4w0iqd5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Sep 2007 00:06:46 -0700")
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEU1QytIVTlZY0dqc1N6
 hGGJl3qZpZCtuKXsjxzFAAACW0lEQVR42l2UXXrqIBCGk67Aoe29Ac4CTPDcGwZ73wLdQDOuQLP9
 8wHG9hT1Mc6bb/5jp7Xed92TVrqeCYfKRVc+XdfDbqbJ8TixG1UDu2a3xkf2H+z+A6Qn7Xk71AA8
 kdJmZg4xpcTshgr2JQSurAswhwDFYQN9r4yxx1BIQqBTBbvqahw9hxRSLOBdFVA89TTOvgSoMaLf
 ABTWOg5Z8lLRNyD7x4WSVHU1DZurThn2HI9Oa561JhTSDUWxq64YqRlmrcdhA73y3rmJY1okotDT
 NzDO2XNGZPnS7A4b6NQ8foQFN2eJmEBR7Du1Q/DRh7R4O50BrGmu0F8i49Iya+ScvtDNqkADB8zD
 pwU9wTu9c8msdNYOO0JvYYyREd9xBOh7zSNc2WMZUYzIDHOpU0Kxe5o9o0eccsr5mNLcwHhC8DoM
 SQkJ5wbUxAdlbDELEpDbclc8sT2gV2HJIrj/si7hDgzPpY4sqxTV+pWkgt7EGesDIFWUnGuK7pkn
 erZoieCVZPGcG3jCJimLwS7IVZY4R3mvoNfzoCfOF0mIG1nna+TadAxzgF5u0b3JTaxcmZtCF1dn
 WSOv63oNl4U3BQCLXOQKWZIHUBWcUci6iuTL7eMOelVAKfp+NkA0kOElN3BbV26AiGZsXEqfa0EQ
 NtATvTAKCeHh7AEEi4knM6S3HwB2eo1zeZQ5fDbgNkCpbEwh8HUTqYDqwUhIG2NQ/k2WH+CVB9LK
 aINy0EeAvgF6KRK0wIaPiX8CioRNpQF7X/8EOnoAPpUvrX8DED7t8B/Bv8ErfnpSfxv4B9rx7BDd
 lxXRAAAAAElFTkSuQmCC
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEUkEQZGKhthUz9wWCXQ
 jD2tnFannIH3wl/TzLL223z084309N2Wne4NAAACXklEQVQ4y22TsWvbQBTGnxLorFNI5ugKItCl
 IfXQ3cFraZqAPcU3HAdZE1RtjUuPo9oaHHG3B6Lr1CUI9M/1vTtLdkofErbez9/39M7vQRnCWluV
 55fn4eGWLhhAc3F2mh9MZht0C4PggoU4K238aQDNmGdsYikisJW9zAdwMHctoaCo7k7ZGBPn2zaC
 qlpv8yjx3loXgP28AxiC1kerdb6TTw49RVA8sGTXy3nvSPGPE2MLtCKFrZavwUd0agm8KsFSemHv
 IgglMj6AWNwOiqOX+JlQdQ/Yy2P0OOkiSEfwawAi5EeFfUhDCdVJlOSo8BH4YMWl7IwQOYJ9Pyiw
 8ayQpuuNRhFsrFr/QAKlTY+hRc42wCFImdDihIDgy5QF4Fz7mCaZ0lwFUKy+3S8I4P3EIKs7cUNg
 VYh3sXPv/NNpwvtO1qGGWn3/6QdFnqBNyGP8YYsBtMeJ6sfYAc9LONqCVTICfw1JPYL7HfAJ4Oa/
 4BrgDeU6uo9hC44B9gaJhv3F76H4ewCgA8HT6q5hn07Ehj4uSBLL6zQcbmvB4XDhXwV74XC7JcCh
 C9Nuq6qyVvDCkGSVIrCbNWhwgKSUpjZ4krzIJ3bcD2uvpKxrY4woBJu77eJEBRIt5dv5dqPWRiqS
 dD2CfG7bAVyhiZGY77XRfI673VQE7qgxY1Tdd9qYwsybBre2seVX09cINAJJHNPlDMdnrcjJaKX6
 Dr+q7kd5O5uCs2t6F1FwLvsXwbFTM5tOp0A9cM4zHF6coTzJOVdfIhAcH3FmGS84JFma8w8EykuO
 ORQgChfP+AGCv0+008iY5CqoAAAAAElFTkSuQmCC
X-Hashcash: 1:20:071005:gitster@pobox.com::3sa9LIpfII7t3wu2:000000000000000000000000000000000000000000000fIb
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
X-PMX-Version: 5.2.1.279297
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61028>

Added a new section beneath "On Automatic following" called "On
Backdating Tags".  This includes an explanation of when to use this
method, a brief explanation of the kind of date that can be used in
GIT_AUTHOR_DATE, and an example invocation of git-tag using a custom
setting of GIT_AUTHOR_DATE.

Signed-off-by: Michael W. Olson <mwolson@gnu.org>
---

[Resending, this time without trying to send through Gmane and munge
Reply-To.]

Junio C Hamano <gitster@pobox.com> writes:

> Michael Olson <mwolson@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Wouldn't it be easier to create the tag with the desired
>>> timestamp from the beginning, by exporting GIT_COMMITTER_DATE?
>>
>> Ah, I didn't know about that environment variable.
>>
>> Would it be possible to mention that option on the git-tag manpage?
>
> Surely, I am kind of surprised if it weren't, but apparently you
> did not find it.  Please make it so.

 Documentation/git-tag.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 990ae4f..2966aa2 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -214,6 +214,27 @@ having tracking branches.  Again, the heuristic to automatically
 follow such tags is a good thing.
 
 
+On Backdating Tags
+~~~~~~~~~~~~~~~~~~
+
+If you have imported some changes from another VCS and would like
+to add tags for major releases of you work, it is useful to be able
+to specify the date to embed inside of the tag object.  The data in
+the tag object affects, for example, the ordering of tags in the
+gitweb interface.
+
+To set the date used in future tag objects, set the environment
+variable GIT_AUTHOR_DATE to one or more of the date and time.  The
+date and time can be specified in a number of ways; the most common
+is "YYYY-MM-DD HH:MM".
+
+An example follows.
+
+------------
+$ GIT_AUTHOR_DATE="2006-10-02 10:31" git tag -s v1.0.1
+------------
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>,
-- 
1.5.3.4
