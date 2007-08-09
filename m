From: "Evan Carroll" <me@evancarroll.com>
Subject: Problem with http-repos vs filesys-remote-repos
Date: Thu, 9 Aug 2007 18:40:05 -0500
Message-ID: <428b865e0708091640x715a5950x128da5da493cef2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 01:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJHc0-0005nh-Vm
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 01:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151AbXHIXkM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 19:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbXHIXkL
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 19:40:11 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:8162 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbXHIXkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 19:40:07 -0400
Received: by fk-out-0910.google.com with SMTP id z23so532681fkz
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 16:40:06 -0700 (PDT)
Received: by 10.82.183.19 with SMTP id g19mr3239599buf.1186702805732;
        Thu, 09 Aug 2007 16:40:05 -0700 (PDT)
Received: by 10.82.171.9 with HTTP; Thu, 9 Aug 2007 16:40:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55485>

A disclaimer:: I could have mucked with anything, I will not place the
blame on git as if I had strictly adhered to the tutorial
instructions. Anything I did was through the UI, there was no mucking
with files. Thanks in advance and good luck:

I have one repos located on /var/git/scraper.git, it houses a
small-inhouse project which I'm trying to use to sell git with.
Unfortunately, I've had a very difficult time doing everything with
git. Namely, pulling and pushing. It appears as if I git-clone this
using the file-system (fs) addressing I get a repos which `git log`
shows was last modified on Aug 9th. However, if I check this out with
a git-clone using apache, which is simply hosting
/var/git/scraper.git, I get a repos which was last updated on aug 7th
- thus it is missing *a lot* of devel time. Now the 7th was when I
created the --bare repos from my working directory git. All of the
gits involved are using the latest stable version 1.5.2.4, they all
built cleanly. The log is as follows:

AUG 7TH LAST COMMIT SHOWN WITH `git log`
ecarroll@x60s:~/git_clone$ git-clone "http://localhost:8080/scraper.git"
Initialized empty Git repository in /home/ecarroll/git_clone/test2/.git/
Getting alternates list for http://localhost:8080/scraper.git
Getting pack list for http://localhost:8080/scraper.git
Getting index for pack e1abd952a37bfe85805996e69bee52a2c6ca8b5e
Getting pack e1abd952a37bfe85805996e69bee52a2c6ca8b5e
 which contains b7aa242f4934d8fd0fbd46f1da6ed6a9b067c7fd
walk b7aa242f4934d8fd0fbd46f1da6ed6a9b067c7fd
walk 03e5aa7139b0bac0d8ba0172deea269e9ae260d8
walk 440123ec8cc4914b01cefbb47becb17f323d5be0
walk 80bbe821fba30e0c441488b8587c76d4b158b419
walk 43a52216c1a257e167f07d8d3f6a21f4b7ca2e7d
walk d60274e965eee8ad4621297681a3fbfa34b5bf94
walk e2bbe073669dee862f0952b8b270109604c0ecb4
walk 8274ce6c3bfa09b61b5552aa37192bcfaff6c365
walk 4d4a5169d50e0311eb8e040e81d4a5ee169e571e
walk d19088ace71dd6253b9375fcc255aad562617215
walk f41ecbd9bcd77f752c580e7ea817932aee4c3a67
walk 3ca0832b9f3749358bf38362c682eb65d1178f06
walk a01f7090894aeb68c53a31aa47d829857b8941f8
walk 802e9e5da7500e009a60b3474b8810ce2e8919f6
walk a785f5356f04989d5e5f377b47ce511838966801
walk ec139d2ed248c4ac1cb9ac212de340beec5b98d0
walk 505070b2e973344d68167fa74b7d0677e696389f
walk d15f3cc11d321f85d7171370d39a6e1c84c9d404
walk 3c49542c1e792dafdb3550646112761405d2228c
walk abd521924488a67aedb7fb04b4c125419aac4b31
walk fcf61439f3e8b9056820f4c645e2b0708909a49b
walk 5b9403e4ce6a99fd796ee6431e046401b4f22654
walk 346efee6bc1b5b040f7f3216fb797b7fe47169f4
walk 907c664f95a67f543318c9d98c77afad6a42cde6
walk c7400a750462b74f7e3ca38944e99c1bad0ffb40
walk 00cf9ba3c7b1bef826f798872abfe0f6ae2c88cf
walk 7a11ff1ca92714502619e1efab81d010660f1d3a
walk a85d4c191b625c540aa7c6404d3a4077e40c54ad
walk a1f168e39b561e715ea211c816681ac9d3bb723b
walk 2b7d935254f3dd96c0ed9917ba9eeb4ebb6a435e
walk 142ebf8d6db33be291979763eb1c5ad148efd52a
walk 9c567513df3e1cde356a8b481ddc48427676a9cf
walk 058ce00fc69ec1c220cee1a6d1cd4a1dbf7ccf8d
walk bcffa5ee33a03021b15351275349003ebdf3b4c9
walk cb7085573783e385333c1e6fdda23abc98a1b4b5
walk c270169aa2031abb0baeedfe6b518482ec5fd6ab
walk 8399e6433890370194d63572ba94b9a211238d72
walk cc04ae74ce1c2f7430d4eed7b8ce8a46e8f0e04c
walk 6e9b3fb69d0fdd7f6d4c9184a4ed46713d685d30
walk 99b6b4627d9cebcb616d33956bd80f3756336985
walk b253c3ca8fb18c4e9a151a00ededa98300eb8ff0
walk cd2f1f880ad3f0771e4458d62d2add8cad1251bb
walk c4ef38a70079ba6408345ffccace89863f994220
walk de21695739e313a6eba9e67965b91dbbabde4455
walk dfa6f513114a67f873e1a8304b51110f3a5e4861
walk 17c9e0b434ab918dc566049115a522cbdf3f1686
walk 90f1cb3e801d54ebcc6fb9d6bb7ddf1df1ba0cca
walk d3da5763afbc5c22f2a69a4040ae4c7203c061ce
walk 07b5c81f66dbc025e22e51feb1911088b50e6eea
walk 29b78272554de6a2565ff392bd9f3d3c123e805d
walk 75721e0ce144d90f97bbd48663263da9a6ef9366
walk b4604048a6c0208288a2468de98e12500c7e1fc3
walk 132777acf1b8770774c3efb3a4783a575f8d013f
walk a1095219e06b9b62bb5e06338146bfe97719bd32
walk 2e625354fce8384bad459a26ec27e841ecd63609
walk be9e8d9233171bbd86a3dc473238bc86c2766567
walk d0ec8e0706f11fc0fb942e34d4f4fec338870a79
walk 6d4a3791943549d59f31a04b6d328d466d1ab554
walk 2a8eba32ae6a0d2b826dc3dd4c4a555b550b939e
walk 7fdbe0eb9806bc76d9f55527a83d4f0005502b28
walk fca1be7a710df50aeb86545348d859021adc2e29
walk 60eb65a60345727a3215c579d836d1e6ca6977f4
walk 2fea2cd7474131af90d791331dfe45f711711794
walk 7da3e7bc32ca0019bff07d5339504997ec711a06
walk 0647f6f9c1b2f9e09dbd26dd4f8e8c270cdda715


AUG 9TH LAST COMMIT SHOWN WITH `git log`.
ecarroll@x60s:~/git_clone$ git-clone /var/git/scraper.git/ ./test1
Initialized empty Git repository in /home/ecarroll/git_clone/test1/.git/
remote: Generating pack...
remote: Done counting 384 objects.
remote: Deltifying 384 objects...
Indexing 384 objects... done
remote: 00% (384/384) donene
Total 384 (delta 173), reused 359 (delta 157)
 100% (384/384) done
Resolving 173 deltas...
 100% (173/173) done


While you are chewing on that there are two things I want to see done
to the UI (my wishlist)::

more serious error messages -- they are so far off as is, if someone
could patch just the simple `git-clone` to error more intelligently if
it isn't addressed to the .git directory!! If someone hosts there WD
on a webhost, they intuitively think they should (i did) clone it by
addressing the curdir, and not the './.git', the undescriptive error
message stings.
"Perhaps git-update-server-info needs to be run there?" needs to be
accompinied by a more logical newbieish error of the sort "Are you
targetting the working directory."

My second complaint is everything reporting it is "up to date." If
everything is up to date say "everything", if both things are mimicked
the pedagogic term is "synchronized", if the repos isn't totally
synced, then tell me what you have updated/merged and where you put
what you received!

ecarroll@x60s:~/git_clone$ diff <(find ./test1 -printf "\n%f") <(find
./test2 -printf "\n%f" )
2c2
< test1
---
> test2
9a10
> Moose-extends
29,30c30,31
< pack-183aa1d0a0a7db1c379268003d9a1ad64ddb9063.pack
< pack-183aa1d0a0a7db1c379268003d9a1ad64ddb9063.idx
---
> pack-e1abd952a37bfe85805996e69bee52a2c6ca8b5e.idx
> pack-e1abd952a37bfe85805996e69bee52a2c6ca8b5e.pack
31a33
> b7
35a38
> Moose-extends
55d57
< CSV.pm

Please cc me in all responses me@evancarroll.com
-- 
Evan Carroll
System Lord of the Internets
me@evancarroll.com
832-445-8877
