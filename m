From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Thu, 8 Mar 2007 13:09:07 +0100
Message-ID: <81b0412b0703080409u5ae64698tfa70a8ba2de65df@mail.gmail.com>
References: <20070308041618.GA29744@spearce.org>
	 <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com>
	 <20070308083317.GB30289@spearce.org>
	 <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703080157n413de6f6q35ae24e2620df91d@mail.gmail.com>
	 <20070308100237.GF30289@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Andy Parkins" <andyparkins@gmail.com>,
	"Bill Lear" <rael@zopyra.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:09:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPHQo-0003ue-6V
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 13:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbXCHMJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 07:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbXCHMJK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 07:09:10 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:50616 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbXCHMJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 07:09:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so609164nfa
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 04:09:07 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FFhIXL0YEJDirwKNUviUwmoS+6hyZ/87S0ie/yDQQOR8IYIEplkQ3UtPF9mEDxpbEUacqtEej8p4l+GtRWzcRHD29tiJWWESSCECM+aUSjKUUfY1wavbMgfJiS7dvwd8AuFJp8OBssd75d8tL2fLFRQpdIOXoadeLOuT40bbh6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QvkzMWZ/xoo/3pdUZ6U+CFZBSCqccjvbJjZ9o4oiVYnNadzUt3i53c60cw+ycyBLV4CeUhCp+auhoqkezihTO2FCMM1awbX8M/vctRdby4MutkJbCcnxkMo8Q8P4LtfWfGbBxiAZlDahNM8gpbKTQbF/lOKsJYSyzP2uEfOfn1w=
Received: by 10.78.160.2 with SMTP id i2mr34366hue.1173355747706;
        Thu, 08 Mar 2007 04:09:07 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Thu, 8 Mar 2007 04:09:07 -0800 (PST)
In-Reply-To: <20070308100237.GF30289@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41739>

On 3/8/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > The proprietary OS' will have the problem, though. And far sooner
> > than 1300 refs (w2k has only 32767 bytes for command line).
> > Besides, don't overestimate peoples readiness to be careful
> > about reference names. I would expect reference names over
> > 100 bytes in length to happen regularly (generated from file names
> > appended with a timestamp, for example).
>
> Cygwin's lifted that argument handling to be unlimited.

Actually, it didn't at all. Cygwin conveniently forgets that not all
programs use cygwin1.dll. Cygwin is just the wrong place
were the problems of windows stupidity have to be fixed,
and so it does not fix them.
