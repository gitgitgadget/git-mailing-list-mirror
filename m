From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 3/4] Added test for RefUpdate branch deletion
Date: Sat, 23 Aug 2008 01:28:18 +0200
Message-ID: <200808230128.19035.robin.rosenberg.lists@dewire.com>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org> <1219445147-6801-3-git-send-email-charleso@charleso.org> <1219445147-6801-4-git-send-email-charleso@charleso.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles O'Farrell <charleso@charleso.org>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:31:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWg63-0003os-GG
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500AbYHVXaC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 19:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbYHVXaB
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:30:01 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:45088 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756213AbYHVXaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2008 19:30:00 -0400
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 7F56C382AC; Sat, 23 Aug 2008 01:29:58 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 6699E37FBB; Sat, 23 Aug 2008 01:29:58 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 549FA37E43;
	Sat, 23 Aug 2008 01:29:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219445147-6801-4-git-send-email-charleso@charleso.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93400>

l=F6rdagen den 23 augusti 2008 00.45.46 skrev Charles O'Farrell:

Having unit tests is lovely and we appreciate that very much. We need m=
ore of this.=20
Unfortunately it breaks. Is the fix the obvious one?

-- robin

> +	public void testDeleteHead() throws IOException {
> +		final RefUpdate ref =3D updateRef(Constants.HEAD);
> +		delete(ref, Result.NOT_ATTEMPTED, true, false);

junit.framework.AssertionFailedError: expected:<NOT_ATTEMPTED> but was:=
<REJECTED_CURRENT_BRANCH>
	at junit.framework.Assert.fail(Assert.java:47)
	at junit.framework.Assert.failNotEquals(Assert.java:280)
	at junit.framework.Assert.assertEquals(Assert.java:64)
	at junit.framework.Assert.assertEquals(Assert.java:71)
	at org.spearce.jgit.lib.RefUpdateTest.delete(RefUpdateTest.java:61)
	at org.spearce.jgit.lib.RefUpdateTest.testDeleteHead(RefUpdateTest.jav=
a:75)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImp=
l.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAcc=
essorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:623)
	at junit.framework.TestCase.runTest(TestCase.java:164)
	at junit.framework.TestCase.runBare(TestCase.java:130)
	at junit.framework.TestResult$1.protect(TestResult.java:106)
	at junit.framework.TestResult.runProtected(TestResult.java:124)
	at junit.framework.TestResult.run(TestResult.java:109)
	at junit.framework.TestCase.run(TestCase.java:120)
	at org.eclipse.jdt.internal.junit.runner.junit3.JUnit3TestReference.ru=
n(JUnit3TestReference.java:130)
	at org.eclipse.jdt.internal.junit.runner.TestExecution.run(TestExecuti=
on.java:38)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(Rem=
oteTestRunner.java:460)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.runTests(Rem=
oteTestRunner.java:673)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.run(RemoteTe=
stRunner.java:386)
	at org.eclipse.jdt.internal.junit.runner.RemoteTestRunner.main(RemoteT=
estRunner.java:196)
