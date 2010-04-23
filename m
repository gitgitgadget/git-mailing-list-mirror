From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:22:34 +0200
Message-ID: <4BD166DA.1010803@dbservice.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>	<20100422155806.GC4801@progeny.tock>	<87wrvzs590.fsf@frosties.localdomain>	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>	<87sk6n4426.fsf@frosties.localdomain>	<7vsk6n2n48.fsf@alter.siamese.dyndns.org>	<vpq7hnzcgjq.fsf@bauges.imag.fr> <87r5m6tu0l.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:23:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5F6V-0003qJ-Uh
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778Ab0DWJXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:23:14 -0400
Received: from office.neopsis.com ([78.46.209.98]:44498 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0DWJXN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:23:13 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 23 Apr 2010 11:22:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <87r5m6tu0l.fsf@frosties.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145601>

On 4/23/10 11:09 AM, Goswin von Brederlow wrote:
> For SVN users it gets much worse:
>
> vi existing-file.c # do some changes
> vi new-file.c      # create the file
> git add new-file.c
> vi new-file.c      # do some more changes
> git commit
>
> A SVN user would expect the current working copies of existing-file.c
> and new-file.c to be commited. Instead only new-file.c is commited and
> only the fist modification.

But is compatibility with the SVN interface really what we want to aim 
for? Just because their interface works that way doesn't mean it's the 
correct way.

tom
