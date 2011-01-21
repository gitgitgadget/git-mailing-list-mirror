From: Eric Montellese <emontellese@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Fri, 21 Jan 2011 17:00:47 -0500
Message-ID: <AANLkTikj-+bVW6P42Ejz+T=CtKTwUKBF6BmEDSBeZbL6@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com> <201101211436.32033.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 23:01:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgP2o-0000o4-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 23:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab1AUWBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 17:01:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33457 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab1AUWBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jan 2011 17:01:10 -0500
Received: by bwz15 with SMTP id 15so2043468bwz.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Rh+T6BS4oO2x9X5YRxr901a/00tSkfPa9JLJugoJ1rk=;
        b=izvvOCmxLKmsIum7iyzNXj3BA1BoSZUjW0njl4MRJQba3M3pnqMLJ7Enk0YetqXQ+4
         FNG9WyCxJK+qs4QhNi8GFxojLGDM9UIGEYrzQPbKHL7cHeHStt/hrHQX5F0PyjcFuNQN
         7U5AwW0usVrGQ8C8diyfyweJOeVi0VscOv5eM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qFtvUGCWT9XHIThDkwqKBKCUBBi9TY0iTmW+mgVOVq8kkUOUQvFtI5e5/I7fxAyuqS
         kQZK6y7WpPtppAASRKfl62jLpDN+l8hoaWWPomGnx0KVqQgJQN48rLp55/zU3KO2Wz77
         2nH57nC/Hw8WCuOumoS1H6umx5UDt19V2d5II=
Received: by 10.204.61.199 with SMTP id u7mr1237063bkh.6.1295647267973; Fri,
 21 Jan 2011 14:01:07 -0800 (PST)
Received: by 10.204.60.11 with HTTP; Fri, 21 Jan 2011 14:00:47 -0800 (PST)
In-Reply-To: <201101211436.32033.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165395>

Thanks Wesely,

I did take a look at git annex -- it looks to me as though that
project is more of a special-case, allowing users to use git to track
things like music and movies.  While it's possible this might be
usable for the use case I described, what I'm really looking for is a
true extension of git which allows binaries to be treated differently
(if the user desires) when using git as a source management tool.

The major difference I see with git-annex is that the user must
specifically tell git-annex to download certain files.  Instead, I
want the user to always automatically have *all* of the files (both
source and binaries) for the current revision -- but not necessarily
for hundreds (thousands?) of past revisions (which as git is
implemented currently would take up many gigabytes)

git-annex does look like a neat piece of software, but I don't think
it quite fits here -- thank you again for the comment though!

Eric


On Fri, Jan 21, 2011 at 4:36 PM, Wesley J. Landaker <wjl@icecavern.net>=
 wrote:
> On Friday, January 21, 2011 11:57:21 Eric Montellese wrote:
>> To whet your appetite to read all of the below (I know it's long),
>> this is the root of the solution:
>>
>> --- =A0 =A0 =A0 Don't track binaries in git. =A0Track their hashes. =
=A0 =A0 =A0 ---
>
> Comment from the peanut gallery:
>
> I haven't read your approach in great detail, but just in case you ar=
e not
> aware, there is a project call git-annex <http://git-annex.branchable=
=2Ecom/>
> by Joey Hess that I believe takes a similar approach.
>
> Since you've obviously given this a lot of thought, you might want to=
 take a
> peek at that and see if it already does what you want, or if your pro=
posal
> does something significantly different/better.
>
