From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] deprecate the new loose object header format
Date: Wed, 9 May 2007 14:00:56 -0700
Message-ID: <56b7f5510705091400x37dfe961jfe2a739f2e6842cd@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
	 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
	 <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
	 <alpine.LFD.0.99.0705091048120.24220@xanadu.home>
	 <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.99.0705091422130.24220@xanadu.home>
	 <56b7f5510705091316t78e31032k95815e190239717e@mail.gmail.com>
	 <alpine.LFD.0.99.0705091633590.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 23:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HltHY-000795-T5
	for gcvg-git@gmane.org; Wed, 09 May 2007 23:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbXEIVBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 17:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758861AbXEIVBG
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 17:01:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:27641 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758533AbXEIVBE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 17:01:04 -0400
Received: by wr-out-0506.google.com with SMTP id 76so379892wra
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:01:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D5YaQTBsnbmVGP8WicAUlXj+t2RNmhaHfwPNh/Dca8Q+qlMMs+fMu+7Y8y6gX1cHvrthmDagz6OiSik2TJdRNG+Ba8tG3O4VBsO1Dumroes53WSI2iYRsovEplNDE9RoO+56UcuOm63uY5yzWGdgWikehofVkKeUoXywalr6MQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rYtmGDpNaRolmGEJfg9TfVtUEMxAx0dFmHbnJdB98E8FBDRaMgpXwHqi5R/moPFb2Fk8mQzk5yDakUuK5yGVhA2cng+PsWx5zp9zAjO6Ai5PAi09SALc+8vqT5v+lKkt2drAxJTpuFp7DeTfr1+2C+aL6eWErgk3GpUqF5xQqMk=
Received: by 10.114.167.2 with SMTP id p2mr290735wae.1178744461782;
        Wed, 09 May 2007 14:01:01 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 9 May 2007 14:00:56 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705091633590.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46790>

On 5/9/07, Nicolas Pitre <nico@cam.org> wrote:
> It is not simpler because:
>  2) the object SHA1 is always computed with the legacy header included.
That convinces me.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
