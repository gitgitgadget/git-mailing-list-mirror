From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with an 
	asterisk
Date: Mon, 9 Feb 2009 19:10:41 -0500
Message-ID: <76718490902091610v1a53494ajb24b6a87bf207a78@mail.gmail.com>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
	 <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 01:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWgEU-0002Id-GJ
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 01:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbZBJAKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 19:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbZBJAKm
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 19:10:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:20108 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZBJAKm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 19:10:42 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2034323rvb.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 16:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=io8tylLeppzQVTO2WutD9O1GrFLbDNCbWbvatiE2qbY=;
        b=oSjkcIb1XPnJOojIGQMFR/YN2LTswLiRbJ4Yd/Gz94ff7++VxsyzVwBo59VNcgG1mO
         lJEss8kuZA5hwcUqrRUd44Y0Xjm1c7TCbQKX3A9lLPnHPXDAmbjqsWiVEOAPpH5kON8C
         WQGKvOD7wPkixeLEYJQZnJa62PSgRMB+2WJYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F1r47U2BOCbjYKgaMODj2rc45b0avZhPL9eW7apJPAkSNnUFbcvw7JSjqby72i9G9z
         SchwR8HE77JwiQx+MLO37wNWmaRCfLTlswiykZLtJjPvz8rV6edjwteJLwxsQXmqAxhN
         witf4v0ZRPBNLStvqnLYsCwuQmp9hWsPU8b+s=
Received: by 10.140.172.20 with SMTP id u20mr1935575rve.244.1234224641239; 
	Mon, 09 Feb 2009 16:10:41 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109165>

On Mon, Feb 9, 2009 at 6:49 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 9 Feb 2009, Jay Soffian wrote:
>
>> Teach git branch -{r,a} how to interpret remote HEADs and highlight the
>> corresponding remote branch with an asterisk, instead of showing literal
>> "<remote_name>/HEAD".
>
> Let's hope that nobody's scripts rely on a single star in front of the
> local HEAD...

Perhaps you'd be happier with a different marker for the remote head,
but in any case, git branch is a porcelain, isn't it?

j.
