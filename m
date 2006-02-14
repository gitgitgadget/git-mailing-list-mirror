From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 10:22:51 -0500
Organization: Network Appliance, Inc.
Message-ID: <43F1F5CB.10402@citi.umich.edu>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080605060809080203040208"
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 16:39:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F922J-00023W-Fg
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 16:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWBNPXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 10:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBNPXS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 10:23:18 -0500
Received: from citi.umich.edu ([141.211.133.111]:61038 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1161081AbWBNPWy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 10:22:54 -0500
Received: from [10.58.52.206] (nat-198-95-226-230.netapp.com [198.95.226.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Chuck Lever", Issuer "CITI Production KCA" (verified OK))
	by citi.umich.edu (Postfix) with ESMTP id 358761BACA;
	Tue, 14 Feb 2006 10:22:53 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060214100844.GA1234@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16136>

This is a multi-part message in MIME format.
--------------080605060809080203040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Karl Hasselstr=F6m wrote:
> On 2006-02-14 09:26:41 +0000, Catalin Marinas wrote:
>=20
>=20
>>Another thing that's missing in StGIT is the import of a series of
>>patches. At the moment I run a small shell script to import
>>individual patches.
>=20
>=20
> One thing I would like to see in stgit is the opposite of "stg
> commit"; instead of converting patches to regular commits, take the
> topmost regular commits and convert them to patches.
>=20
> For example, "stg uncommit foo bar baz" would -- regardless of any
> existing patches, applied or not -- convert the top three regular
> commits, with comments and all, to stgit patches called foo, bar, and
> baz. These would be already applied, at the bottom of the stack. I
> imagine all one would have to do is to modify some stgit metadata, so
> the operation could be really cheap.
>=20
> Of course, "stg uncommit" is allowed to reject any commit with more
> than one parent, since those can't be represented as stgit patches.
>=20
> This would perhaps not add much power to an all-stgit workflow, but it
> would be a really convenient way to edit recent git history. Sort of
> like a more convenient rebase. And a great way to lure new users. :-)

i think you want "stg pick --reverse" ?

--------------080605060809080203040208
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------080605060809080203040208--
