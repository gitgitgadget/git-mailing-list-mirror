From: Antony Male <antony.male@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 13:04:35 +0000
Message-ID: <4F688063.8080802@gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <4F67EB1F.30205@gmail.com> <m3y5qv32d9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 14:04:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9yk4-0007lW-Ad
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 14:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab2CTNEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 09:04:42 -0400
Received: from anakin.london.02.net ([87.194.255.134]:33352 "EHLO
	anakin.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907Ab2CTNEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 09:04:42 -0400
Received: from [127.0.0.1] (87.194.161.58) by anakin.london.02.net (8.5.140)
        id 4EEB63D201ACA451; Tue, 20 Mar 2012 13:04:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <m3y5qv32d9.fsf@localhost.localdomain>
X-Antivirus: avast! (VPS 120320-0, 20/03/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193508>

On 20/03/2012 12:04 pm, Jakub Narebski wrote:
> The "matching" behavior is intende for non-symmetrical situation of a
> workflow where each user has its own separate public publishing
> repository, but can pull from many repositories from other developers
> (but never from one's own).
>
> The situation is assymetrical (even more that "pull" and "push" for
> single upstream repository, in a shared central repository case), so
> configuration is assymetrical.

Sorry, I wasn't clear enough.  I'm well aware of why 'matching' and 
'current' exist, and the workflows for which they're suited.

My point is that these bite new users before they've got to the point of 
developing workflows involving more than one remote.  At that point, 
they're not aware of the need for an asymmetric config, so they're not 
expecting it to be the default.

To take another angle on it, I'd rather our new users said "Hey, there's 
an awesome config option that makes git play nicely with asymmetric 
workflows" than "Why on earth do pull and push interact with different 
remote branches by default".

Thanks,
Antony
