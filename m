From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC re Thunderbird + imap-send
Date: Tue, 10 Feb 2009 07:23:16 -0600
Message-ID: <49917FC4.3000807@codeweavers.com>
References: <4990A4FF.6020404@codeweavers.com> <49915FB6.8010803@drmicha.warpmail.net> <49917208.6000807@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsbp-0002o6-Gm
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 14:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbZBJNXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 08:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbZBJNXh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 08:23:37 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53098 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbZBJNXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 08:23:37 -0500
Received: from jwhite-home.codeweavers.com ([209.240.253.22] helo=[10.0.0.5])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWsaH-0003Q5-RL; Tue, 10 Feb 2009 07:23:35 -0600
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49917208.6000807@beonex.com>
X-Spam-Score: -3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109236>

Ben Bucksch wrote:
> On 10.02.2009 12:06, Michael J Gruber wrote:
>> For a typical text mail in Drafts I see lines like
>> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>> Content-Transfer-Encoding: quoted-printable
>> Any chance we could use that rather than invoke the HTML editor?
>> We would need to shut off q-p and f-f *and* avoid automatic word wrap
>> (or make sure patches don't have longer lines then TBs editor allows),
>> the latter I don't know how to do.
>>    
> I'm not aware that existing headers would influence the send logic (in 
> turning on/off qp or f=f or word wrap).

I both looked at the Thunderbird code and experimented with a variety 
of options and found no way to do this; only the charset seems to
be picked up (and that may actually be a bug, judging by Ben's initial
reaction :-/).

Cheers,

Jeremy
