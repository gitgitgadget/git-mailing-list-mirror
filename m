From: Kris Shannon <kris@shannon.id.au>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 17:38:22 +1100
Message-ID: <478EF7DE.3090709@shannon.id.au>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 07:39:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFOOx-0003RH-2s
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 07:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbYAQGi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 01:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbYAQGi3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 01:38:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:48178 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbYAQGi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 01:38:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so891602wah.23
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 22:38:27 -0800 (PST)
Received: by 10.114.26.1 with SMTP id 1mr2002779waz.80.1200551907122;
        Wed, 16 Jan 2008 22:38:27 -0800 (PST)
Received: from hal.office.sisgroup.com.au ( [122.252.3.76])
        by mx.google.com with ESMTPS id q20sm2617348pog.5.2008.01.16.22.38.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jan 2008 22:38:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 ThunderBrowse/3.2.0.9 Mnenhy/0.7.5.666
In-Reply-To: <478EEAC4.2010006@talkingspider.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70833>

Mike wrote:
> 
> 
> Linus Torvalds wrote:
> 
>> Some people don't split this up, and they tend to make horrible 
>> horrible mistakes, like checking in the *results* of the 
>> post-processing too (ie binary result blobs that can be regenerated 
>> from the other files), because they don't make a clear separation 
>> between the parts they do development on, and the end result.
> 
> Honestly, I think your mode of thinking is centered around compiled 
> languages and linux app(/kernel) development.  The web app 
> development/deployment model is very different.
> 
> With PHP, Python, and Ruby, the development is the deployment.  The 
> source is the output.  You can't develop web apps in those languages 
> unless the source files you're working on are under the doc root of your 
> development server.   "the parts they do development on" and "the end 
> result" *are* the same files.

Not for me.  I've always had my source separate from development docroot
even before I was using proper SCM's.  I've written stuff in all three
languages you mention where deployment to the docroot (development or not)
was more than a simple copy.
