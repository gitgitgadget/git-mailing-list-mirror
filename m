From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: New features in gitk
Date: Mon, 29 Oct 2007 08:31:18 +0000
Message-ID: <8E362637-5AE6-43DC-890D-78BC6B43BDA1@steelskies.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <20071028183216.GA4310@artemis.corp> <18213.6055.235067.730640@cargo.ozlabs.ibm.com> <20071029062000.GB4310@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 09:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImQ2B-0001FS-8t
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 09:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXJ2IbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Oct 2007 04:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbXJ2IbX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 04:31:23 -0400
Received: from smtp1.betherenow.co.uk ([87.194.0.68]:40990 "EHLO
	smtp1.bethere.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbXJ2IbW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2007 04:31:22 -0400
Received: from [192.168.1.65] (87-194-43-188.bethere.co.uk [87.194.43.188])
	by smtp1.bethere.co.uk (Postfix) with SMTP id B061D9803D;
	Mon, 29 Oct 2007 08:31:20 +0000 (GMT)
In-Reply-To: <20071029062000.GB4310@artemis.corp>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62610>


On 29 Oct 2007, at 06:20, Pierre Habouzit wrote:

> On Sun, Oct 28, 2007 at 11:13:43PM +0000, Paul Mackerras wrote:
>>>   * the 'sha1' input field is a major pain in the UI: the cut&paste
>>>     interaction is very poor. I don't know why, but it's often =20
>>> very very
>>>     hard to really copy the sha id, probably because it's =20
>>> selected by
>>>     default.
>>
>> It's selected so that the contents are in the cut buffer and you can
>> paste them in an xterm with middle-button.  Possibly I need to check
>> that control-C (or command-C under macos) is properly bound to copy.
>
>   Well, doing ^C doesn't always copy it (probably a glitch wrt which
> input has the focus), and it certainly doesn't synchronize with the =20
> cut
> buffer for me. And it doesn't work for anyone at work either. I use =20
> ion
> with the KDE clipboard manager (klipper -- because I never managed to
> find a clipboard manager that is as good yet, not depending upon KDE)=
,
> and at work most people use KDE, with the same klipper. Maybe it's =20
> a bad
> interaction, I should try to use it under gnome or so to see if it is=
=2E
>

=46WIW, I have exactly the same problem under OS X.  I've never figured=
 =20
out a pattern that gives a guaranteed copy - I'll try playing around =20
today and see what I can find.

Actually, while I'm here, gitk semi-regularly ignores =E2=8C=98Q, which=
 =20
ought to quit on OS X.