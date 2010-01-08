From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Fri, 08 Jan 2010 18:21:55 -0500
Message-ID: <4B47BE13.7070509@gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> 	<20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> 	<7vocl7yxef.fsf@alter.siamese.dyndns.org> <20100107200509.6117@nanako3.lavabit.com> 	<7vtyux3bx1.fsf@alter.siamese.dyndns.org> <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com> 	<fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com> 	<32541b131001081231x1b6ac8c1k30084e4abf8cc896@mail.gmail.com> <fabb9a1e1001081237n11fa61b5m63fa46fac2ad8d4a@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 00:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTO9j-0000Mc-TJ
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 00:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab0AHXWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 18:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376Ab0AHXWD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 18:22:03 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:56261 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab0AHXWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 18:22:00 -0500
Received: by ywh6 with SMTP id 6so19961867ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ZhE500X9H9qGNuAkkAryT6jXt63FwY5W3LOzJh6Q/8U=;
        b=sMHlyaS01IlPDw2NEhnQicbJsyL00dc8nWwLfFmpsPL8GYh/WrIXNSWTejjBe0WHe+
         hOjQ9hHX+7f70GCzJPATgFOO5C1d2BSwCCRpwybhZzlo1KdZy4rMoH614wI0mKTa4WUd
         1NJwgDZdyDk++4PXV2Bl5WOyYrerf83e2CPYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=nYAIdFN7UK0enKHmv80e1d7s/fV36ygCnW7Aq0bzcA256SDGG0oANpsun+eCZdkWQs
         7eiaIKm7UDlH72EP+qPFSfbfzM6xR/6FpbYRUsz+ZcLSy7qjxQU1iVtw0IhexavmbfmI
         4+97pNZ3OUtjBsLr5u9FG32gH9mOgFDiwdcdk=
Received: by 10.90.16.33 with SMTP id 33mr14392968agp.15.1262992918484;
        Fri, 08 Jan 2010 15:21:58 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 14sm11477644gxk.10.2010.01.08.15.21.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 15:21:57 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <fabb9a1e1001081237n11fa61b5m63fa46fac2ad8d4a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136494>

Sverre Rabbelier wrote:
> Heya,
> 
> On Fri, Jan 8, 2010 at 15:31, Avery Pennarun <apenwarr@gmail.com> wrote:
>> Thanks, I didn't know about that one.  But my general point is still:
>> we seem to have two implementations when the functionality of one is
>> actually a superset of the other.  As far as I can see, anyway.  So
>> the obvious way to reduce the duplicated code is to simply eliminate
>> the less-featureful implementation.
> 
> *cough* git sequencer *cough*
> 

*cough* not in my ${PATH} *cough*
