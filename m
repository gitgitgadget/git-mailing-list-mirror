From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Fri, 17 May 2013 22:20:49 +0300
Message-ID: <51968311.1020107@bracey.fi>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 21:21:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdQD8-0003ZS-Uw
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 21:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab3EQTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 15:20:54 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:50794 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756634Ab3EQTUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 15:20:54 -0400
Received: from mail644.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id 76B37FFB8E8
	for <git@vger.kernel.org>; Fri, 17 May 2013 21:20:52 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 17 May 2013 21:20:52 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 17 May 2013 21:20:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
In-Reply-To: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
X-Ovh-Tracer-Id: 9444892843629711468
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500005/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeekucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224732>

On 15/05/2013 23:34, Felipe Contreras wrote:
>   
> I think I'm using 'upstream' for something it was not intended to, and
> I think the current 'upstream' behavior should be split into
> 'upstream' and 'base'.
>
I found myself thinking the same thing. It's really convenient being 
able to set your topic branch's upstream to another local branch, so git 
rebase works without parameters. But then I can't use upstream to point 
to a remote version of that topic branch. I want my topic branch to know 
both that it's based on master (or origin/master), and that it's 
upstream is origin/topic.

So, yes, here's a vote in favour of the general concept.

Kevin
