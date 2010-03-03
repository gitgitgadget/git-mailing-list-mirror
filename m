From: Andrew Myrick <amyrick@apple.com>
Subject: Re: git svn fetch gives Index mismatch
Date: Wed, 3 Mar 2010 13:18:26 -0800
Message-ID: <BAEC677B-D84E-4052-86EC-3A7194EFFD03@apple.com>
References: <4B8ECF97.4030006@felixmoeller.de>
Mime-Version: 1.0 (Apple Message framework v1137)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Felix_M=F6ller?= <mail@felixmoeller.de>
X-From: git-owner@vger.kernel.org Wed Mar 03 22:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmvxf-0003Tz-U0
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 22:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab0CCVS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Mar 2010 16:18:28 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:52992 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0CCVS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 16:18:26 -0500
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out4.apple.com (Postfix) with ESMTP id 8B2DA8ECD974;
	Wed,  3 Mar 2010 13:18:26 -0800 (PST)
X-AuditID: 11807136-b7bafae000000e8d-26-4b8ed222ffe2
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay15.apple.com (Apple SCV relay) with SMTP id 4F.1F.03725.222DE8B4; Wed,  3 Mar 2010 13:18:26 -0800 (PST)
In-Reply-To: <4B8ECF97.4030006@felixmoeller.de>
X-Mailer: Apple Mail (2.1137)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141481>

This may have been fixed with commit 41c01693ac13846c73a31c8f5c3a60206e=
1643be.  Try git-1.7.0.

-Andrew

On Mar 3, 2010, at 1:07 PM, Felix M=F6ller wrote:

> Hi,
>=20
> I am new to git and tried to checkout the Subversion Repository of AD=
empiere. https://adempiere.svn.sourceforge.net/svnroot/adempiere
>=20
> I get the following doing it:
>> [fm@thinkpad adempiere.git]$ git svn fetch
>> Index mismatch: fac38f8fdc7d816e9dd26b469e08a98428f3f2a5 !=3D 0aea77=
1bc7629d194ada8bb448e863ffe7868189
>> rereading e662b48c06fb9a263f717546ffbb41a39f94d597
>>        M       mvcForms/db/ddlutils/postgresql/functions/round.sql
>>        M       mvcForms/db/ddlutils/oracle/functions/documentNo.sql
> > ...
>>        M       mvcForms/client/src/org/compiere/grid/ed/VLookup.java
>>        M       mvcForms/client/src/org/compiere/print/Viewer.java
>>        M       mvcForms/client/src/org/adempiere/apps/graph/Graph.ja=
va
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/branches/stable/data/hu_HU
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/data/hu_HU
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/branches/adempiere341/zkwebui/WEB-INF/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/branches/stable/zkwebui/WEB-INF/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/extend/posterita/webui/WEB-INF/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/extension/posterita/webui/WEB-INF/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/zkwebui/WEB-INF/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/branches/adempiere341/base/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/base/src
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/migration/351a-352a
>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnro=
ot/adempiere/trunk/migration/352a-353a
>> merge-base e662b48c06fb9a263f717546ffbb41a39f94d597 7ac062d801daf465=
37377154daf39e5b21a8f447: command returned error: 1
>=20
> charon on IRC helped me a lot trying to debug it. I provided the foll=
owing operations:
> # git show fac38f8fdc7d816e9dd26b469e08a98428f3f2a5
> tree fac38f8fdc7d816e9dd26b469e08a98428f3f2a5
>=20
> mvcForms/
> # git show 0aea771bc7629d194ada8bb448e863ffe7868189
> tree 0aea771bc7629d194ada8bb448e863ffe7868189
>=20
> mvcForms/
> # git show e662b48c06fb9a263f717546ffbb41a39f94d597
> commit e662b48c06fb9a263f717546ffbb41a39f94d597
> Author: tobi42 <tobi42@f8025ce2-341d-0410-ac50-9b82273f5115>
> Date:   Fri Oct 23 14:06:12 2009 +0000
>=20
>    minor compile fix
>=20
>    git-svn-id: https://adempiere.svn.sourceforge.net/svnroot/adempier=
e/branches/metas@10762 f8025ce2-341d-0410-ac50-9b82273f5115
>=20
> diff --git a/mvcForms/client/src/org/compiere/apps/form/VInOutGen.jav=
a b/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java
> index 9f27863..896a340 100644
> --- a/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java
> +++ b/mvcForms/client/src/org/compiere/apps/form/VInOutGen.java
> -218,7 +218,7 @@ public class VInOutGen extends InOutGen implements F=
ormPanel
>=20
> # git show trunk gives
>> # git show trunk
>> commit 7ac062d801daf46537377154daf39e5b21a8f447
>> Author: teo_sarca <teo_sarca@f8025ce2-341d-0410-ac50-9b82273f5115>
>> Date:   Fri Oct 23 08:14:49 2009 +0000
>>=20
>>    FR [ 2884541 ] MRequestUpdate should detect automatically the fie=
lds
>>    https://sourceforge.net/tracker/?func=3Ddetail&aid=3D2884541&grou=
p_id=3D176962&atid=3D879335
>>=20
>>    git-svn-id: https://adempiere.svn.sourceforge.net/svnroot/adempie=
re/trunk@10757 f8025ce2-341d-0410-ac50-9b82273f5115
>>=20
>> diff --git a/base/src/org/compiere/model/MRequestUpdate.java b/base/=
src/org/compiere/model/MRequestUpdate.java
>> index 00bf881..728a6fa 100644
>> --- a/base/src/org/compiere/model/MRequestUpdate.java
>> +++ b/base/src/org/compiere/model/MRequestUpdate.java
>=20
>=20
> I am using git-1.6.6.1-1.fc12.i686.
>=20
> I'd appreciate help how to get it working. Keep in mind I am a git be=
ginner...
>=20
> Thanks for your help
> Felix M=F6ller
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
