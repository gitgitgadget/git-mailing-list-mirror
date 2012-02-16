From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Identify Commit ID from an Extracted Source Snapshot
Date: Fri, 17 Feb 2012 00:43:29 +0100
Message-ID: <4F3D94A1.2040706@elegosoft.com>
References: <BEDA323D25EF6045A68DAB9FD91A0BF123A85B38@DB3PRD0402MB118.eurprd04.prod.outlook.com> <4F3D8A7C.2020400@elegosoft.com> <4F3D8EFF.9000806@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: James Walmsley <james@fullfat-fs.co.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Feb 17 00:44:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyB0P-000445-34
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 00:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab2BPXos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Feb 2012 18:44:48 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:58337 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab2BPXos (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 18:44:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 32148DE8CC;
	Fri, 17 Feb 2012 00:44:45 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k+lAzazrQHVv; Fri, 17 Feb 2012 00:44:45 +0100 (CET)
Received: from [192.168.1.101] (g231216233.adsl.alicedsl.de [92.231.216.233])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id DBF27DE8CB;
	Fri, 17 Feb 2012 00:44:44 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120212 Thunderbird/10.0.1
In-Reply-To: <4F3D8EFF.9000806@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190923>

On 02/17/2012 12:19 AM, Sam Vilain wrote:
> On 2/16/12 3:00 PM, Michael Schubert wrote:
>> On 02/16/2012 11:06 PM, James Walmsley wrote:
>>> I couldn't find this on google, and I have no idea if its even=20
>>> possible. I have several zip files from previous versions of my=20
>>> source code. (I imported svn into git). I would like to add TAGS
>>> to git which represent the versions based on the files in my zip=20
>>> archives.
>>>=20
>>> Does anyone know how to do this?
>>=20
>> If it's just about providing the ancient code together with the=20
>> (imported) more recent history from SVN, you could create an extra=20
>> orphan branch for each zip packet, add the files, commit and=20
>> eventually tag.
>>=20
>> If your question is more like "how do I tell git to find out where=20
>> this old code fits in my history and eventually place it there",=20
>> the answer is: you cannot do it. No VCS will do this and
>> especially not Git.
>=20
> Once you've got a tree in git which corresponds to the contents of
> the zip file, you can use git diff --stat TREEID COMMITID
>=20
> You can get the commitid by obtaining the most recent timestamp for a
> file within the archive, then just using git rev-list --all
> --since=3D... --until=3D... to get a window of commit IDs, and hunt
> around until you find the one with the smallest diff.
>=20
> It's hardly a straightforward thing, usually because the contents of
> the zip file never quite match the exact contents of source
> control=97think autoconf and other files generated for distribution b=
ut
> not stored in the history.  So you need to use a fuzzy search.

I totally disregared the "slicing and rebuilding history approach", jus=
t
because I didn't think that's what James is asking about. Could be fun.
