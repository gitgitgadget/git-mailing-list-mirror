From: Paul Lindner <lindner@inuus.com>
Subject: Re: git-svn error: ambiguous argument
Date: Tue, 11 May 2010 12:44:07 -0700
Message-ID: <0D702391-E490-4942-AAB6-C8C887E671C5@inuus.com>
References: <7A6370FC-843B-43FD-8064-4F44C9C66493@inuus.com> <AANLkTik_YK6_KbRIq4MsrU-LDn8apHQfm1_f7XHKKfX1@mail.gmail.com> <AANLkTil7WdGZTtmwwK0kYPkK6-y4W5HKKLNdtkoI0riM@mail.gmail.com> <AANLkTimE6Wo9HT0p5WMfTggJ059dhDg4fyPeax93VCLy@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 11 21:51:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBvU2-00009c-0e
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 21:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821Ab0EKTu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 15:50:59 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:58048 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602Ab0EKTu6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 15:50:58 -0400
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2010 15:50:58 EDT
Received: by ewy8 with SMTP id 8so1538805ewy.28
        for <git@vger.kernel.org>; Tue, 11 May 2010 12:50:56 -0700 (PDT)
Received: by 10.213.40.201 with SMTP id l9mr2626068ebe.28.1273607052849;
        Tue, 11 May 2010 12:44:12 -0700 (PDT)
Received: from [172.16.27.141] (dagmar.corp.linkedin.com [69.28.149.29])
        by mx.google.com with ESMTPS id 13sm3293217ewy.13.2010.05.11.12.44.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 12:44:11 -0700 (PDT)
In-Reply-To: <AANLkTimE6Wo9HT0p5WMfTggJ059dhDg4fyPeax93VCLy@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146906>

This fixed it for my situation.  Thanks!

On May 11, 2010, at 9:20 AM, Bert Wesarg wrote:

> On Tue, May 11, 2010 at 16:46, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> On Tue, May 11, 2010 at 16:25, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>>> On Mon, May 3, 2010 at 22:51, Paul Lindner <lindner@inuus.com> wrote:
>>>> Hi,
>>>> 
>>>> Since the 1.7 time frame my git-svn imports have stopped working after a period of time.  The error that crops up is:
>>>> 
>>>>  trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' 'd18d09558e4f56fb757b258cb364f38861f84116' '3f498379030b5358d65820415b98cbe338086247' '1e4ed9c6fde9e4b2465a8db6915f32a132634064'   'a51029a8667288556e02055057f250157e0a7f59' '0a7934d4a22563e29ed9857240bc022800f626f7' 'c6a0edb91eed10b86aad74c138422ff8a496ad29' 'd211954a973b92feef86aa130bf5ac253c095574' 'd9e99745569c8cd7d087cd8740f915b34f0f5fa2' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
>>>>  trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' 'd18d09558e4f56fb757b258cb364f38861f84116' '3f498379030b5358d65820415b98cbe338086247' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
>>>>  trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
>>>>  trace: built-in: git 'merge-base' 'd86892a76b3ef4049b87ca50f62846cdff5f204f' 'cb612e24c7d15ff8b4b13822592fff25e1efff13'
>>>>  trace: built-in: git 'rev-list' '--no-merges' 'cb612e24c7d15ff8b4b13822592fff25e1efff13' '--not' '23dfc0fd04cedd8e09c2bfa6f0e79e9a4282bc57'
>>>>  trace: built-in: git 'rev-list' 'dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764'
>>>>  fatal: ambiguous argument 'dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764': unknown revision or path not in the working tree.
>>>>  Use '--' to separate paths from revisions
>>>>  rev-list dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764: command returned error: 128
>>>> 
>>>> This git-svn repo is a shallow clone of a very large svn repo.
>>>> 
>>>> It was initialized like this:
>>>> 
>>>>  git svn init SVNREPO --trunk=network/trunk --branches=network/branches --tags=network/tagz --ignore-paths='^.+/(?:branches)/(?!BR_ENG_PLFM|BR_REL)' network
>>>>  git svn fetch -r 112002
>>>> 
>>>> It appears that one of the branches cannot find it's parent:
>>>> 
>>>>  git log dde42274ac34e4055275ea4926cd8cc259476399^
>>> 
>>> That hit me too. The first revision number is the root commit, which
>>> does not have any parents. Thats why the rev-list command fails.
>> 
>> I think the correct useage should be
>> 
>>    git rev-list dde42274ac34e4055275ea4926cd8cc259476399^!
>> 4ff8e8528dd9d3901c6839080a6f172b8e380764
>> 
>> Making a patch for this doesn't look trivial, because git-svn expects
>> that a commit range is only one argument, not two in this case.
> 
> Can you try this patch, it worked on my site:
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index b3b6964..40ecec0 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3103,7 +3095,11 @@ sub check_cherry_pick {
> 	my %commits = map { $_ => 1 }
> 		_rev_list("--no-merges", $tip, "--not", $base);
> 	for my $range ( @ranges ) {
> -		delete @commits{_rev_list($range)};
> +		if ( $range =~ /^([[:xdigit:]]{40})\^\.\.([[:xdigit:]]{40})$/i ) {
> +			delete @commits{_rev_list(sprintf("%s^!", $1), $2)};
> +		} else {
> +			delete @commits{_rev_list($range)};
> +		}
> 	}
> 	for my $commit (keys %commits) {
> 		if (has_no_changes($commit)) {
> 
> Bert
