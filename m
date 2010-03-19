From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 06:18:26 -0600
Message-ID: <b4087cc51003190518y2a7004c2pf8effaa9f5adf502@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4BA338C1.7030803@alum.mit.edu> 
	<b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com> 
	<alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm> <20100319115445.GA12986@glandium.org> 
	<3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com> 
	<b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Hommey <mh@glandium.org>, david@lang.hm, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:18:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsbAD-0008Oj-7S
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab0CSMSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:18:48 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:36257 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab0CSMSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:18:48 -0400
Received: by fxm19 with SMTP id 19so528221fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=tYlP63Co9764f+SYmFhynTp5dhFaIBXBLlN+iRWeOxs=;
        b=cP3nlQd8pgTjKKqWQ/vCsPt1DwhEmETm4eGIWtWQx5aezV04t9GB53SK4NjFE9zHTw
         dpNm+yDFNXlIpyF76MrK3h9bcXT2mjTw6sLXXyl4XaMHOANlbnfJ9prCioD07hpM8P8p
         HRycInYCuau/4on5YRcSaZulQ73U79z+x7Vts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HE0i+kqldzK+lY4qKNoL7kATNTNCAOTWACt7OKzSJHEOpViC63ISD4ojSUsYPXQvQd
         QKZq3xxqNGTZGf6/5EFJmhgnlER+aKkOp3VSIPbd8HxNTl/XoYFP34O87NXhfhjUkKE3
         a0jKhNtlGvlw4I6DMrKm+4b19En1xUXoI+iAM=
Received: by 10.239.190.145 with SMTP id x17mr568221hbh.201.1269001126211; 
	Fri, 19 Mar 2010 05:18:46 -0700 (PDT)
In-Reply-To: <b4087cc51003190516h42202e34k598a163c246cb9f2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142582>

On Fri, Mar 19, 2010 at 06:16, Michael Witten <mfwitten@gmail.com> wrote:
> The extra uuid `field' can only suffer from typos

I should add that because the uuid `field' would be typed pretty much
only as a config variable and then used by git tools from thenceforth,
the rate at which typos can occur is much less than for the name/email
pair.
