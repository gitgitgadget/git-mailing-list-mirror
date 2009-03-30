From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 4/4] Rename push.default to push.style
Date: Mon, 30 Mar 2009 11:00:03 +0200
Message-ID: <adf1fd3d0903300200v65393b1bif0050392aa44652e@mail.gmail.com>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
	 <1238281804-30290-5-git-send-email-santi@agolina.net>
	 <20090330080115.GA19142@pvv.org>
	 <alpine.DEB.1.00.0903301021540.7534@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDNG-0007QI-J5
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbZC3JAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 05:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbZC3JAH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:00:07 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:46566 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754391AbZC3JAG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:00:06 -0400
Received: by bwz17 with SMTP id 17so1808406bwz.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:00:03 -0700 (PDT)
Received: by 10.103.102.18 with SMTP id e18mr1586018mum.44.1238403603208; Mon, 
	30 Mar 2009 02:00:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903301021540.7534@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115109>

2009/3/30 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 30 Mar 2009, Finn Arne Gangstad wrote:
>
>> On Sun, Mar 29, 2009 at 12:10:04AM +0100, Santi B=E9jar wrote:
>> > push.default was too generic, and also didn't specify if it was ab=
out
>> > remote, refspec, branches, behaviour...
>> > [...]
>> > =A0 =A0 "You can specify what action you want to take in this case=
, and",
>> > - =A0 "avoid seeing this message again, by configuring 'push.defau=
lt' to:",
>> > + =A0 "avoid seeing this message again, by configuring 'push.style=
' to:",
>> > =A0 =A0 " =A0'nothing' =A0: Do not push anything",
>> > =A0 =A0 " =A0'matching' : Push all matching branches (default)",
>> > =A0 =A0 " =A0'tracking' : Push the current branch to whatever it i=
s tracking",
>> > [...]
>>
>> I don't think "push.style" is an improvement. "style" sounds like it
>> affects all pushes.

Not for me. I says the style of the push. But maybe push.mode could be =
better.

>> This configuration variable says what push should do
>> when no refspec is given and none are configured, so the word "defau=
lt"
>> should be in there at least. Maybe "defaultref" would have been bett=
er?

I don't see the point of the word default, a lot of configuration is
to set the default value. Git has branch.name.remote, not
branch.name.defaultremote, or user.email, not user.defaultemail,...

>
> I'd prefer "push.defaultMode", but...
>
>> Some people may have started setting push.default already, so changi=
ng
>> the name may cause additional grief.
>
> ... indeed, it is too late now. =A0The milk has boiled already.

I have it configured, but I think we can fix these type of things
while they are in 'next'.

Santi
