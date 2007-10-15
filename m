From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] [BUG FIXED 2] git-add (-a|-u)  and -n support
Date: Mon, 15 Oct 2007 10:47:46 -0400
Message-ID: <85EE4C64-2174-45D3-A459-69746C9CD51C@mit.edu>
References: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu> <0458D1DA-6261-4DA6-91B0-739F4D35AADF@mit.edu> <E857D120-787F-460B-A167-4B5F4BD2C3B5@mit.edu> <vpq3awd25hs.fsf@bauges.imag.fr> <D44B7811-5A0F-4A31-9DB3-6D2BF645E543@MIT.EDU> <20071015143137.GA7351@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 17:08:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhRFS-0007ZC-K9
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374AbXJOOs2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 10:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbXJOOs1
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:48:27 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55441 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753956AbXJOOs0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:48:26 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9FElmXC008074;
	Mon, 15 Oct 2007 10:47:49 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9FEllco024483
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 15 Oct 2007 10:47:48 -0400 (EDT)
In-Reply-To: <20071015143137.GA7351@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61004>


On 15 Oct 2007, at 10:31:37 AM, Karl Hasselstr=F6m wrote:

> On 2007-10-14 18:00:44 -0400, Michael Witten wrote:
>
>> Here's compromise that is backwards compatible. For both git-add and
>> git-commit:
>>
>>       -a dir [dir2 ...] =3D> all changes in the given dirs.
>>       -a                =3D> all changes from the root.
>>
>> Then we can just leave -u in place for now, and mark it as
>> deprecated.
>>
>> In any case, the goal is to make the intuition solid between
>> git-commit and git-add.
>
> As I recall, Junio had some specific reason for calling the flag -u
> instead of -a. Search in the list archive for the patch that
> introduced the flag, or wait till he gets back and ask him.

I have a feeling it was because -u currently just updates modified
files in the current directory, while -a updated all modified files.

=46ortunately, the suggestion above does not break anything.

Michael Witten

P.S.
When is Junio coming back? I know I know... Look through the =20
archives. :-P