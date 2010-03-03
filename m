From: =?ISO-8859-1?Q?Felix_M=F6ller?= <mail@felixmoeller.de>
Subject: Re: git svn fetch gives Index mismatch
Date: Wed, 03 Mar 2010 23:12:48 +0100
Message-ID: <4B8EDEE0.1020206@felixmoeller.de>
References: <4B8ECF97.4030006@felixmoeller.de> <BAEC677B-D84E-4052-86EC-3A7194EFFD03@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Myrick <amyrick@apple.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 23:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmwna-00062h-CA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 23:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853Ab0CCWMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Mar 2010 17:12:05 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:33791 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0CCWMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 17:12:03 -0500
X-Greylist: delayed 3854 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 17:12:03 EST
Received: from [93.196.25.5] (helo=[192.168.178.20])
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <mail@felixmoeller.de>)
	id 1NmwnP-0004DE-1Y; Wed, 03 Mar 2010 23:11:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
In-Reply-To: <BAEC677B-D84E-4052-86EC-3A7194EFFD03@apple.com>
X-Df-Sender: mail@felixmoeller.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141485>

Hi Andrew,

Am 03.03.2010 22:18, schrieb Andrew Myrick:
> This may have been fixed with commit 41c01693ac13846c73a31c8f5c3a6020=
6e1643be.  Try git-1.7.0.
I am now running a rebuilt git-1.7.0.1-1.fc14.i686 on Fedora 12 and get=
=20
the following with it:

> [fm@thinkpad adempiere.git]$ git svn fetch
> ^[^NIndex mismatch: fac38f8fdc7d816e9dd26b469e08a98428f3f2a5 !=3D 0ae=
a771bc7629d194ada8bb448e863ffe7868189
> rereading e662b48c06fb9a263f717546ffbb41a39f94d597
>         M       mvcForms/db/ddlutils/postgresql/functions/round.sql
>         M       mvcForms/db/ddlutils/oracle/functions/documentNo.sql
=2E..
>         M       mvcForms/client/src/org/adempiere/apps/graph/Graph.ja=
va
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/stable/data/hu_HU
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/data/hu_HU
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/zkwebui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/stable/zkwebui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/extend/posterita/webui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/extension/posterita/webui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/zkwebui/WEB-INF/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/base/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/base/src
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/migration/351a-352a
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/migration/352a-353a
> W: Cannot find common ancestor between e662b48c06fb9a263f717546ffbb41=
a39f94d597 and 7ac062d801daf46537377154daf39e5b21a8f447. Ignoring merge=
 info.
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/zkwebui
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/stable/zkwebui
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/zkwebui
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/zkwebui/css
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/stable/zkwebui/css
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/zkwebui/css
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/branches/adempiere341/base
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/base
> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnroo=
t/adempiere/trunk/migration/All320-340
> r10767 =3D e2069c625b3dc0639b31992186ab0f20da1cbf13 (refs/remotes/met=
as)
>         A       tools/lib/miglayout-3.7.1-swing.jar
>         M       tools/build.xml
so it seems to be handled gracefully now.

Thanks for your tip!

regards
=46elix M=F6ller


> On Mar 3, 2010, at 1:07 PM, Felix M=F6ller wrote:
>> Hi,
>>
>> I am new to git and tried to checkout the Subversion Repository of A=
Dempiere. https://adempiere.svn.sourceforge.net/svnroot/adempiere
>>
>> I get the following doing it:
>>> [fm@thinkpad adempiere.git]$ git svn fetch
>>> Index mismatch: fac38f8fdc7d816e9dd26b469e08a98428f3f2a5 !=3D 0aea7=
71bc7629d194ada8bb448e863ffe7868189
>>> rereading e662b48c06fb9a263f717546ffbb41a39f94d597
>>>         M       mvcForms/db/ddlutils/postgresql/functions/round.sql
>>>         M       mvcForms/db/ddlutils/oracle/functions/documentNo.sq=
l
>>> ...
>>>         M       mvcForms/client/src/org/compiere/grid/ed/VLookup.ja=
va
>>>         M       mvcForms/client/src/org/compiere/print/Viewer.java
>>>         M       mvcForms/client/src/org/adempiere/apps/graph/Graph.=
java
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/branches/stable/data/hu_HU
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/data/hu_HU
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/branches/adempiere341/zkwebui/WEB-INF/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/branches/stable/zkwebui/WEB-INF/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/extend/posterita/webui/WEB-INF/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/extension/posterita/webui/WEB-INF/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/zkwebui/WEB-INF/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/branches/adempiere341/base/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/base/src
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/migration/351a-352a
>>> Couldn't find revmap for https://adempiere.svn.sourceforge.net/svnr=
oot/adempiere/trunk/migration/352a-353a
>>> merge-base e662b48c06fb9a263f717546ffbb41a39f94d597 7ac062d801daf46=
537377154daf39e5b21a8f447: command returned error: 1
