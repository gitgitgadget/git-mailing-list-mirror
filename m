From: Shigeya Suzuki <shigeya@wide.ad.jp>
Subject: Re: Can't build git on Lion?
Date: Sat, 30 Jul 2011 11:47:27 +0900
Message-ID: <4E3370BF.6070504@wide.ad.jp>
References: <CAF5DW8+efO0jcynyhg3GCZc5JByHwQzudqtrJXF87YazYjF2mw@mail.gmail.com> <loom.20110728T141556-724@post.gmane.org> <20110729063812.GA64045@gmail.com> <CAF5DW8+9ketSNULU67YwY7QDqMSLrOGQAXXodD9Dr2p-ivWo6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Jack Nagel <Jack.Nagel.1@ndsu.edu>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jul 30 05:07:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmzth-0003RO-Ei
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 05:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab1G3DHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 23:07:13 -0400
Received: from sh.wide.ad.jp ([203.178.137.85]:55585 "EHLO sh.wide.ad.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1G3DHM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 23:07:12 -0400
X-Greylist: delayed 1182 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jul 2011 23:07:12 EDT
Received: from twinbee.jpk.shigeya.org (7c2947b5.i-revonet.jp [124.41.71.181]) (authenticated (0 bits)) by mail.wide.ad.jp (8.14.1+3.5Wbeta/8.14.1/smtpfeed 1.20) with ESMTP id p6U2lSuK017302 (using TLSv1/SSLv3 with cipher DHE-RSA-CAMELLIA256-SHA (256 bits) verified NO); Sat, 30 Jul 2011 11:47:28 +0900 (JST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAF5DW8+9ketSNULU67YwY7QDqMSLrOGQAXXodD9Dr2p-ivWo6w@mail.gmail.com>
X-Enigmail-Version: 1.2
OpenPGP: id=580251E3
X-TagToolbar-Keys: D20110730114727794
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178173>

Just for info, I have successfully built v1.7.6 on both Xcode 4.1 and
4.2, both on Lion.

shigeya

On 2011/07/30 3:51, Jonathan del Strother wrote:
> On 29 July 2011 07:38, David Aguilar <davvid@gmail.com> wrote:
>> On Thu, Jul 28, 2011 at 12:19:01PM +0000, Jack Nagel wrote:
>>>> There's no /System/Library/Perl/5.10.0 directory, but there is a 5.10
>>>> directory.  Symlinking that to 5.10.0 gives me :
>>>
>>> I've seen this issue pop up serveral times in the last few days in various
>>> places; the solution is to install (or re-install) XCode as the installation
>>> does not persist correctly across upgrades. Versions prior to 4.1 are
>>> incompatible with Lion; also, after you download it from the App Store, make
>>> sure that you run the "XCode Installer" app that is placed in your
>>> Applications folder.
>>
>> The last time I saw this error it was because the Perl version
>> changed.  "make clean" fixed it for me.  YMMV.
> 
> Oh, good point.  Yes, 'make clean' fixed things, thanks for the tip.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
