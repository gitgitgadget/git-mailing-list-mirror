From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: git-svn error: ambiguous argument
Date: Tue, 11 May 2010 18:20:44 +0200
Message-ID: <AANLkTimE6Wo9HT0p5WMfTggJ059dhDg4fyPeax93VCLy@mail.gmail.com>
References: <7A6370FC-843B-43FD-8064-4F44C9C66493@inuus.com>
	 <AANLkTik_YK6_KbRIq4MsrU-LDn8apHQfm1_f7XHKKfX1@mail.gmail.com>
	 <AANLkTil7WdGZTtmwwK0kYPkK6-y4W5HKKLNdtkoI0riM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Paul Lindner <lindner@inuus.com>
X-From: git-owner@vger.kernel.org Tue May 11 18:20:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBsCV-00053d-4x
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 18:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab0EKQUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 12:20:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37631 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab0EKQUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 12:20:46 -0400
Received: by fxm19 with SMTP id 19so615443fxm.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/yYkpfHCFI8ELg+jOcuI5EkPMqX2dlTRVW4a27jIDDI=;
        b=KBNZXx+Y1nfQhfnkPWbsBuapUGlFCkLS29JD039w5MtdpB7RBbd+q6LYeHe+Sfgso6
         vMQ6wL+R6HmqZULHmcoLkCubKXW7Cfg1ZdhcwbCSAzqY8qpS3ueir2blajKNbvT5nI7K
         0YWTfVxwdzxa6z8XM2F/rJtzHvkCZJpLUyOCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w0zxnIH61F+JOxhn0wdw63lizpcMR6nWi30XQmWW4px2GmLqI+dOU3xFNlQ+ZDexgN
         y/40pWo1dsGrjp9SasG8dB7yXIUd17n8k4ClqjvAypmmknCiBey7IHGfu8UvDgTZ4B9I
         4BOQqLUEy4QL6rCnrRgcubn8hOXrtAH9jFumU=
Received: by 10.223.16.84 with SMTP id n20mr6544449faa.94.1273594844494; Tue, 
	11 May 2010 09:20:44 -0700 (PDT)
Received: by 10.223.113.146 with HTTP; Tue, 11 May 2010 09:20:44 -0700 (PDT)
In-Reply-To: <AANLkTil7WdGZTtmwwK0kYPkK6-y4W5HKKLNdtkoI0riM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146900>

On Tue, May 11, 2010 at 16:46, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> On Tue, May 11, 2010 at 16:25, Bert Wesarg <bert.wesarg@googlemail.co=
m> wrote:
>> On Mon, May 3, 2010 at 22:51, Paul Lindner <lindner@inuus.com> wrote=
:
>>> Hi,
>>>
>>> Since the 1.7 time frame my git-svn imports have stopped working af=
ter a period of time. =C2=A0The error that crops up is:
>>>
>>> =C2=A0trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b1382=
2592fff25e1efff13' 'd18d09558e4f56fb757b258cb364f38861f84116' '3f498379=
030b5358d65820415b98cbe338086247' '1e4ed9c6fde9e4b2465a8db6915f32a13263=
4064' =C2=A0 'a51029a8667288556e02055057f250157e0a7f59' '0a7934d4a22563=
e29ed9857240bc022800f626f7' 'c6a0edb91eed10b86aad74c138422ff8a496ad29' =
'd211954a973b92feef86aa130bf5ac253c095574' 'd9e99745569c8cd7d087cd8740f=
915b34f0f5fa2' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
>>> =C2=A0trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b1382=
2592fff25e1efff13' 'd18d09558e4f56fb757b258cb364f38861f84116' '3f498379=
030b5358d65820415b98cbe338086247' '--not' 'd86892a76b3ef4049b87ca50f628=
46cdff5f204f'
>>> =C2=A0trace: built-in: git 'rev-list' '-1' 'cb612e24c7d15ff8b4b1382=
2592fff25e1efff13' '--not' 'd86892a76b3ef4049b87ca50f62846cdff5f204f'
>>> =C2=A0trace: built-in: git 'merge-base' 'd86892a76b3ef4049b87ca50f6=
2846cdff5f204f' 'cb612e24c7d15ff8b4b13822592fff25e1efff13'
>>> =C2=A0trace: built-in: git 'rev-list' '--no-merges' 'cb612e24c7d15f=
f8b4b13822592fff25e1efff13' '--not' '23dfc0fd04cedd8e09c2bfa6f0e79e9a42=
82bc57'
>>> =C2=A0trace: built-in: git 'rev-list' 'dde42274ac34e4055275ea4926cd=
8cc259476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764'
>>> =C2=A0fatal: ambiguous argument 'dde42274ac34e4055275ea4926cd8cc259=
476399^..4ff8e8528dd9d3901c6839080a6f172b8e380764': unknown revision or=
 path not in the working tree.
>>> =C2=A0Use '--' to separate paths from revisions
>>> =C2=A0rev-list dde42274ac34e4055275ea4926cd8cc259476399^..4ff8e8528=
dd9d3901c6839080a6f172b8e380764: command returned error: 128
>>>
>>> This git-svn repo is a shallow clone of a very large svn repo.
>>>
>>> It was initialized like this:
>>>
>>> =C2=A0git svn init SVNREPO --trunk=3Dnetwork/trunk --branches=3Dnet=
work/branches --tags=3Dnetwork/tagz --ignore-paths=3D'^.+/(?:branches)/=
(?!BR_ENG_PLFM|BR_REL)' network
>>> =C2=A0git svn fetch -r 112002
>>>
>>> It appears that one of the branches cannot find it's parent:
>>>
>>> =C2=A0git log dde42274ac34e4055275ea4926cd8cc259476399^
>>
>> That hit me too. The first revision number is the root commit, which
>> does not have any parents. Thats why the rev-list command fails.
>
> I think the correct useage should be
>
> =C2=A0 =C2=A0git rev-list dde42274ac34e4055275ea4926cd8cc259476399^!
> 4ff8e8528dd9d3901c6839080a6f172b8e380764
>
> Making a patch for this doesn't look trivial, because git-svn expects
> that a commit range is only one argument, not two in this case.

Can you try this patch, it worked on my site:

diff --git a/git-svn.perl b/git-svn.perl
index b3b6964..40ecec0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3103,7 +3095,11 @@ sub check_cherry_pick {
 	my %commits =3D map { $_ =3D> 1 }
 		_rev_list("--no-merges", $tip, "--not", $base);
 	for my $range ( @ranges ) {
-		delete @commits{_rev_list($range)};
+		if ( $range =3D~ /^([[:xdigit:]]{40})\^\.\.([[:xdigit:]]{40})$/i ) {
+			delete @commits{_rev_list(sprintf("%s^!", $1), $2)};
+		} else {
+			delete @commits{_rev_list($range)};
+		}
 	}
 	for my $commit (keys %commits) {
 		if (has_no_changes($commit)) {

Bert
