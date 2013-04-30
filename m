From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Tue, 30 Apr 2013 10:28:21 -0400
Message-ID: <517FD505.9000706@xiplink.com>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org> <1367262904-9885-1-git-send-email-marcnarc@xiplink.com> <7vli81ghsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Lukas Fleischer <git@cryptocrack.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 16:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXBXf-0003p8-BW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 16:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225Ab3D3O2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 10:28:22 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:53102 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192Ab3D3O2U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 10:28:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp17.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3D20738027C;
	Tue, 30 Apr 2013 10:28:19 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp17.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C604038023C;
	Tue, 30 Apr 2013 10:28:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130404 Thunderbird/17.0.5
In-Reply-To: <7vli81ghsf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222937>

On 13-04-29 05:15 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> This started out as an attempt to make the backward compatibility notes
>> more parsable, but then I just kept going...
> 
> Thanks.
> 
>>   * "git bundle" did not like a bundle created using a commit without
>> -   any message as its one of the prerequistes.
>> +   any message, as it is one of the prerequistes.
> 
> This is actually saying a different thing.  
> 
> When you create a bundle, you can say "you can only unbundle this in
> a repository that has commit X", with "git bundle create $name ^X Y
> Z".  Such a commit X is called the bundle's prerequisite.  You can
> have more than one prerequisite, e.g. "... ^X ^W Y Z".
> 
> But if you create a bundle by using a commit that does not have any
> message as X (i.e. the bundle's prerequisite), the "git bundle" did
> not like to read the resulting bundle output.
> 
> So <a commit <without any message> as its (bundle's) one of the
> prerequisites> is what the original wanted to say.  The rewrite
> makes it read like "For a commit, having a message is a requirement
> to be used in a bundle", at least to me.

Thanks, I did get that wrong.

CC'ing Lukas, who wrote the relevant commit (5446e33f35).

How about:

* "git bundle" can create a bundle that has a commit without a message as
  a prerequisite, but it could not work with such a bundle.

		M.
