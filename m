From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 23:04:39 +0100
Message-ID: <200701242304.40904.jnareb@gmail.com>
References: <17846.53626.895660.762096@lisa.zopyra.com> <ep8ght$dlf$3@sea.gmane.org> <20070124212731.GE4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 23:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9qDe-0007Ac-Q5
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 23:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXAXWDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 17:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXAXWDr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 17:03:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:18222 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbXAXWDr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 17:03:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so694804nfa
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 14:03:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FzRwJoaKILF1yahjgR6XrCGtyfl35nhKCVzA1J1EH0BSf8Met5UABT7fu+j9opOJ1EnlcMFxwqgR4M9U07vyinMnxGvTutBcmMFaIPeTog3OHvY+Utvd4mExprQf/XQfvSbwBIIaX0mlEMcmfavpzOyWLGZ2hiKwvLTHGio7kq8=
Received: by 10.49.13.14 with SMTP id q14mr1212887nfi.1169676225047;
        Wed, 24 Jan 2007 14:03:45 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id x26sm1473729ugc.2007.01.24.14.03.44;
        Wed, 24 Jan 2007 14:03:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070124212731.GE4083@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37685>

Yann Dirson wrote:
> On Wed, Jan 24, 2007 at 09:46:49PM +0100, Jakub Narebski wrote:
>> Yann Dirson wrote:
>>=20
>>> What was particular about this tree, is that we are several people
>>> working on it, namely developpers taking care of the app, and me as
>>> build manager taking care of the build mechanics as well as kernel+=
OS.
>>> So the task was logically divided: one dev would merge the app, and=
 I
>>> would merge everything else. =A0As you see, it's far from one-file
>>> merges, but the problem is quite similar.

>> I wonder if fake-recording resolutions in git-rerere would help
>> in that case...
>=20
> Hm.  Looks like that would require being able to communicate rerere
> results from one workspace to another.

Another solution would be to record partial merge (using "ours" strateg=
y
for files we don't want to merge), then --amend it.=20

--=20
Jakub Narebski
Poland
