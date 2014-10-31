From: Hin-Tak Leung <hintak_leung@yahoo.co.uk>
Subject: Re: Regression and failure to clone/fetch with new code Re: git-svn performance
Date: Fri, 31 Oct 2014 01:40:31 +0000
Message-ID: <1414719631.37308.BPMail_high_carrier@web172302.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Fri Oct 31 02:40:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk1Cf-0006IW-UH
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 02:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161511AbaJaBke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 21:40:34 -0400
Received: from nm17-vm8.bullet.mail.ir2.yahoo.com ([212.82.96.223]:45914 "EHLO
	nm17-vm8.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161369AbaJaBkd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 21:40:33 -0400
Received: from [212.82.98.60] by nm17.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 01:40:32 -0000
Received: from [212.82.98.99] by tm13.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 01:40:32 -0000
Received: from [127.0.0.1] by omp1036.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 01:40:32 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 11863.50152.bm@omp1036.mail.ir2.yahoo.com
Received: (qmail 92339 invoked by uid 60001); 31 Oct 2014 01:40:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s1024; t=1414719631; bh=9hPUXwOYp/vp5eU4Zl3NofVuBtKpKZWNOVAmkxUlfwk=; h=Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=NJ3nRoVGDonsdVZEztk9Bc7YORSXFRPSJDmK87fLqO8YmX6D5ULOkN+RuqssHECRvR5DmCl0F29sQTbgE8iFE0/6y4skFEeZ5Tn6nCYngShx27MLTCeIFU5qBzDDdOagn0MZ/SMvnhkKaNUfJqQj0gNeZ5rrXbEPIMWngoqrJPU=
X-YMail-OSG: zJ5tm2kVM1lqV9mNNsuJICeRlH30Mkm35gZneNqfkdaqJaW
 oqHFFxii58.v_eRE0RSfjlmhgvfKf_pi7vbUKBkeTCXUW2uppXaQZBcsWxoe
 4aJaJF.xGO3PaG0.zt.arKP0Y3uRuJzqWmWJdRLKTyAOhuh_UMF__jEyQVGX
 gopmwo6kW6Miyh7g6bmiZkZ5tbpapbkHEYkVzMCnX7boP0JeSDIVfVzug8cC
 TS9ZXBp8JshYgVx1Cem2eJWp2.ov6j_8A78VpjW21mevP1j5DvgK_L7cfeev
 pCTrEb4NPAALMKbioftg9PCT0xct_NVS6ua.6ujUWMyA6UVrwR4G8vMfk_bB
 XPN3408WvMuX5_dUmQXbvbR6Hi_eC892IfgZJ11MNp3eyCYYhWqQPV1qj32M
 .9lttQheupraMV8rU1GfCSuw8Ngp0JiYhfAsEbb8FDpeXG5O7mddcBSu9vtb
 xV2EG8rxUWQKjBjD9qo_B7eyRld.3HJXcooQ3.zHtwb8.wp2WVRhmdq8R8kx
 39_d82lvD9H.TPW_rwvMXJVJe2isyLBhMaaQHkgUrI.wSSe9qZaTXUBipw59
 2UwjO1U7d0hh5wiHLnhbnC_yJSMNNzPCXhYEsQF65YEgL1YoGmxeNWrasb2Q
 6vyioms9wGg2WwHXfB9dJsSFZEfHyxVJVvt7hpqrvNHraCrLw9oIyqpRnPR3
 c9PBzVqepN.JKnTUWrT0e5QUFTOLs7wIGyvtmJbAV6AUe
Received: from [86.30.137.134] by web172302.mail.ir2.yahoo.com via HTTP; Fri, 31 Oct 2014 01:40:31 GMT
X-Rocket-MIMEInfo: 002.001,Cg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBUaHUsIE9jdCAzMCwgMjAxNCAwODo0NiBHTVQgRXJpYyBXb25nIHdyb3RlOg0KDQo.SGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToNCj4.IEhlcmUgaXMgdGhlIGRhdGEgZHVtcGVyIGluZm8gLiBJIHRyaWVkIHRoZSBkdW1wZXIgY29kZSBvbiB0aGUgUiByZXBvDQo.PiBhcyB3ZWxsLCBhbmQgc2F3IHRoYXQgYWdhaW5zdCB0aGUgdmlydHVhbCBib3ggcmVwbywgdGhlcmUgaXMgb25lIA0KPj4BMAEBAQE-
X-Mailer: YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org






------------------------------
On Thu, Oct 30, 2014 08:46 GMT Eric Wong wrote:

>Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
>> Here is the data dumper info . I tried the dumper code on the R repo
>> as well, and saw that against the virtual box repo, there is one 
>> curious difference - $self->{last_rev} is a string rather than a number.
>> I tried hacking around doing "$x += 0;" to coerce last_rev
>> to a number at various places but didn't get very far. There seems to be some caching
>> code in RA->get_dir so presumably that's why the same code run
>> on one repo gives it as string while on another gives it a number. Hope
>> you can figure where the coersion to string happened.
>
>Thanks, I'm not able to reproduce the issue, but can you try the
>following?
>
>diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>index 75cdac9..82d6108 100644
>--- a/perl/Git/SVN/Ra.pm
>+++ b/perl/Git/SVN/Ra.pm
>@@ -153,6 +153,7 @@ sub url {
> sub check_path {
> 	my ($self, $path, $r) = @_;
> 	my $cache = $self->{cache}->{check_path};
>+	$r = int($r);
> 	if ($r == $cache->{r} && exists $cache->{data}->{$path}) {
> 		return $cache->{data}->{$path};
> 	}
>@@ -169,6 +170,7 @@ sub check_path {
> sub get_dir {
> 	my ($self, $dir, $r) = @_;
> 	my $cache = $self->{cache}->{get_dir};
>+	$r = int($r);
> 	if ($r == $cache->{r}) {
> 		if (my $x = $cache->{data}->{$dir}) {
> 			return wantarray ? @$x : $x->[0];
>---
>The above should apply to my current master which has some
>minor cleanups (which I hope to send to Junio tomorrow).
>
>The following changes since commit fbecd99861ea5795aeba46faf2ac7a8c1b70d485:
>
>  Update draft release notes to 2.2 (2014-10-24 15:02:17 -0700)
>
>are available in the git repository at:
>
>  git://bogomips.org/git-svn.git master
>
>for you to fetch changes up to da0bc948ac2e01652a150fd4a57cebad6143242c:
>
>  git-svn: add space after "W:" prefix in warning (2014-10-30 08:31:28 +0000)
>
>----------------------------------------------------------------
>Eric Wong (11):
>      git-svn: reduce check_cherry_pick cache overhead
>      git-svn: cache only mergeinfo revisions
>      git-svn: remove mergeinfo rev caching
>      git-svn: reload RA every log-window-size
>      git-svn: remove unnecessary DESTROY override
>      git-svn: save a little memory as fetch progresses
>      git-svn: disable _rev_list memoization
>      Git.pm: add specified name to tempfile template
>      git-svn: prepare SVN::Ra config pieces once
>      git-svn: (cleanup) remove editor param passing
>      git-svn: add space after "W:" prefix in warning
>
>Jakob Stoklund Olesen (2):
>      git-svn: only look at the new parts of svn:mergeinfo
>      git-svn: only look at the root path for svn:mergeinfo
>
>Sveinung Kvilhaugsvik (1):
>      git-svn.txt: advertise pushurl with dcommit
>
> Documentation/git-svn.txt |   4 ++
> perl/Git.pm               |   5 +-
> perl/Git/SVN.pm           | 125 ++++++++++++++++++++++++++++------------------
> perl/Git/SVN/Ra.pm        |  90 ++++++++++++++++++---------------
> 4 files changed, 134 insertions(+), 90 deletions(-)
