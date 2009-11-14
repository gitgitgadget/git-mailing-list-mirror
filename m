From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sun, 15 Nov 2009 00:35:19 +0100
Message-ID: <4AFF3EB7.5080606@gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com> 	<fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com> 	<7d4f41f50911141129n967374ap7d92296c5723e31e@mail.gmail.com> <fabb9a1e0911141138r5279650ge57db2413e2321a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Victor Engmark <victor.engmark@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 00:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9S9d-0008Pb-1Z
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 00:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZKNXfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 18:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZKNXfY
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 18:35:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:28181 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbZKNXfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 18:35:24 -0500
Received: by ey-out-2122.google.com with SMTP id 9so604542eyd.5
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=4F9bo6JIVTMyHNSLTPJiCpOrkl0ij/3eTastpQSY0xE=;
        b=UGlYnpKAgo2ds26zzKnW4iWqH6xRzq1X3sL44TFL9tFbMSqkr+53BDkOkuNBOuM9gy
         rr7j9sEVm+Bte69JH/ULDKJcla2dRaKO9ZuAIbE/UmKmFu97QJnHrXEzs76kS/KO9Rcw
         /6pl1n1G45ugxn/m1JysdZU4OzBpsBsQiEv8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=YR3j7r2MXIeFIuLCjQyQs+pDyvoCy4F1dkcaSONrZ0q3A/AlP58J24lUbF8XUvFa67
         NhifbMgwSpGQXK2oU0OXAMHtkM72LrARWETiLsTaET5Ei2VEzVyi8Z1CVVopq/o0Ywc9
         a3sPZIbnZmb/CnQ+FLK5z0M2l9elFHm53oYA0=
Received: by 10.213.23.143 with SMTP id r15mr3642340ebb.94.1258241728995;
        Sat, 14 Nov 2009 15:35:28 -0800 (PST)
Received: from ?192.168.2.101? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 5sm3809187eyh.34.2009.11.14.15.35.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 15:35:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <fabb9a1e0911141138r5279650ge57db2413e2321a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132896>

Sverre Rabbelier schreef:
> Heya,
> 
> On Sat, Nov 14, 2009 at 20:29, Victor Engmark <victor.engmark@gmail.com> wrote:
>> Do I need to run something after fetch to see them?
> 
> Your working copy is probably not up to date anymore, try:
> 
> $ git rebase git-svn
> 
Why not just
$ git svn rebase
?
