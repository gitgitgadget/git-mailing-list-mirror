From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 09:27:19 +0200
Organization: gmx
Message-ID: <699c08632232180166145f70c7f16645@dscho.org>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
 <1443150875.3042.3.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com,
	git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 09:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfNPy-0007nZ-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 09:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbbIYH13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 03:27:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:64825 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422AbbIYH11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 03:27:27 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M5LJv-1acH9b3HB9-00zY9Y; Fri, 25 Sep 2015 09:27:20
 +0200
In-Reply-To: <1443150875.3042.3.camel@kaarsemaker.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:1vMgihmeg/Sosealgyic3fTxWsEwBbjyEndrfRSFDZGot5zMlTV
 /l6FsaMq1i4VML1tbjUALoRNWLJajA+NJOsc6AK70Gr0yPyEBkU5F3vz46IviWsGTPu9GPh
 s/+iiPKRbVKhhAGNdgeoLbsOtpF+Rz4WBZjL2T9ntHWiNsZBnHcjIwN6SqRj/zmGIk5WW45
 Eo8j5J1rwKVIdQuq4sUOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iq3y9dWMx+0=:OYXyqn7QB+HrC4DVANWkqz
 Wot4tmtrbFN8EDyZyN8lLj9+mNL11byK6SPXmLXTGsmdKePSCqglP3utAthke5MvFwd60c5wW
 f11SrIAwjAW6hML+bTvmnLOtAmR1Cf5Am9rAC5U/UDSWnuwOGVCjMMj1sGwqmHO7Aa8XK0OGv
 7SuoJ4dNT2BRIA7KV2JKYKEU31q7FZJ2WxYdiubPl8NiPeaKzmRBu9bsh6agpuMAGEQozMw10
 pNX/JkoFq/Vsnw9yC6qUCDGvTfx4rljPaqkPS/QAYu5rg0GCCoTuc/g2u4VGYRz3I6N7ubafI
 PCA172tpb2baizqOhAgy82Y8am2BWWiMhfnD0H7vL7sW0yoN+IulWg7inZfHVOjXNZ4ppW7oV
 7iwxrmpbmSFdhDHQi/K3g2NQgNYorU7eBisLXMnDFRFdJvOE8JdnbqeGTL/98pGh54/9tEfHz
 eVHtM4U70UmAVU+idZ7ExJ6MGKkXp2nUi74E36Fh7fDimFCF4vZyRmja0Xola+LZqn2CwRLid
 FT1TCbFW/GnGmaUMfJIyXgC6h2oPNQl3azknYtnogAxNjrLR1OMeT1/bHobffGB+mSVnkQ+jD
 qYLp4OuPIBl3csk51bZrUl1GemGXYzRlk0mWonUQ+iNKEw6vGUozeQ/rosNijNiLFBNlaCL4V
 1X5twStP/hYGHgmDVLZI4JLIdX3mkyKw7wp7M+L8W2uTCC/dgbDBBWBBMcKl+fjS8f7D3aAu2
 R+IBlegVF2yBm9yiLTfmIUGIJS+jakmeQ9IaMg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278650>

Hi,

On 2015-09-25 05:14, Dennis Kaarsemaker wrote:
> On do, 2015-09-24 at 17:41 -0700, Junio C Hamano wrote:
>> larsxschneider@gmail.com writes:
>>
>> > My idea is that the owner of "https://github.com/git/git" enables this account
>> > for Travis (it's free!). Then we would automatically get the test state for all
>> > official branches.
>>
>> The last time I heard about this "it's free" thing, I thought I
>> heard that it wants write access to the repository.
> 
> It does not need write access to the git data, only to auxiliary GitHub
> data: commit status and deployment status (where it can put "this
> commit failed tests"), repository hooks (to set up build triggers),
> team membership (ro) and email addresses (ro).

If that still elicits concerns, a fork could be set up that is automatically kept up-to-date via a web hook, and enable Travis CI there.

Junio, if that is something with which you feel more comfortable, I would be willing to set it up. Even if the visibility (read: impact) would be higher if the badges were attached to https://github.com/git/git proper...

Ciao,
Dscho
