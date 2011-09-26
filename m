From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Mon, 26 Sep 2011 06:28:30 +0200
Message-ID: <4E7FFF6E.4070906@alum.mit.edu>
References: <4E7A3BDE.3040301@alum.mit.edu> <7vy5xh1whq.fsf@alter.siamese.dyndns.org> <4E7AF1AE.5030005@alum.mit.edu> <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com> <20110922171340.GA2934@sigill.intra.peff.net> <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com> <20110922205856.GA8563@sigill.intra.peff.net> <4E7C5A3B.10703@alum.mit.edu> <20110923193341.GA26820@sigill.intra.peff.net> <4E7D7329.7070800@alum.mit.edu> <20110924061555.GB13974@sigill.intra.peff.net> <4E7DB916.6010606@alum.mit.edu> <7vwrcwq70k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 06:28:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R82oD-0003lh-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 06:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931Ab1IZE2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 00:28:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50098 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1IZE2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 00:28:44 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED060.dip.t-dialin.net [84.190.208.96])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8Q4SUNZ031050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Sep 2011 06:28:30 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vwrcwq70k.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182090>

On 09/26/2011 06:09 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 09/24/2011 08:15 AM, Jeff King wrote:
>> For most software projects, the user does
>>
>>     git pull
>>     make
>>
>> daily.  There is nothing that a nasty .gitconfig can do that can't be
>> done more easily by a nasty Makefile (or anything else in the build
>> process).  The moment I pull from Junio's repository and run a build
>> without having personally done a full code review first, I've given
>> Junio complete pownership of my account.
> 
> I suspect that argument is somewhat leaky.
> 
> Will I be the _only_ one you will be pulling from?  What if I were not so
> careful and relay a contaminated in-tree configuration file (which I would
> never use myself) to trusting downstream users like you?

I'm not saying that trusting in-tree configuration files makes sense for
everybody, and in the open-source world one must be very careful about
doing so.  But I think that among closely-cooperating groups (e.g.,
personal projects, many projects in industry) (1) we don't pull from
outside the group and (2) we are forced to trust each other pretty
completely anyway.  So I think that there are many sane use-cases for
giving users the opportunity to "bless" an in-tree config.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
