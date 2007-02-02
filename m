From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 15:23:37 +0100
Message-ID: <200702021523.38169.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702021055.49428.jnareb@gmail.com> <45C341CD.7020301@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Feb 02 15:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCzKZ-00071n-BV
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 15:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423174AbXBBOW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 09:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423180AbXBBOW3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 09:22:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:1705 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423174AbXBBOW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 09:22:27 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1259989nfa
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 06:22:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FpbWFOC6gdEm7zmHvQ+yeoscuLArB9fIW38GMYfNUDdw8p5MDhwxhg3zJcvMdTqZgLcGg0x55uoJaZk3t7lbGE86fjS3mnqwKeIii+L7ILWzT8t+pLPQef7Q1AvnrBa9FTz7X74v9i9VKeH65fd/XRDk3PmbRZHo+27NNKF1gus=
Received: by 10.49.21.8 with SMTP id y8mr6538863nfi.1170426145783;
        Fri, 02 Feb 2007 06:22:25 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 28sm4388600ugc.2007.02.02.06.22.25;
        Fri, 02 Feb 2007 06:22:25 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <45C341CD.7020301@fs.ei.tum.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38500>

Simon 'corecode' Schubert wrote:
> Jakub Narebski wrote:
>> 
>> By the way, RCS / CVS rewrote relevant data (to have diff from the top
>> structure) on each commit.
>> 
>> I wonder if git could generate pack on the fly fastimport like...
> 
> What do you mean with that?  generate the pack on which occasion?
> CVS import?  I do this already. 

On commit.
-- 
Jakub Narebski
Poland
