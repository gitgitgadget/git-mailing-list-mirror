From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: git branch documentation improvements
Date: Tue, 11 May 2010 20:27:04 +0200
Message-ID: <201005112027.05818.ahartmetz@gmail.com>
References: <201005070024.41172.ahartmetz@gmail.com> <201005081839.37790.ahartmetz@gmail.com> <4BE7A629.7050709@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jon Seymour <jon.seymour@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 11 20:27:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBuBN-0000DA-KZ
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 20:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456Ab0EKS1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 14:27:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34482 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541Ab0EKS1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 14:27:12 -0400
Received: by fxm19 with SMTP id 19so758291fxm.19
        for <git@vger.kernel.org>; Tue, 11 May 2010 11:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=d+eTwhWliDgM1XZH5tPU/+iD/0Ch9aZXyM6dxsH+7xE=;
        b=C3o9Z3P571EWX4vTwxROImGAiDikg8DF2cME2wHxBiJf7sg21WvqDua4Et5sOwRNe3
         /AURe6c8WC1vgAe3rZKQyzaXnXcjGXUD8I4eL6qYrzqCB3UpzpyBivzBGH6J5uHrYmeE
         /lRXc1yBpSxheIkxjCaaGVnfTUPqKfkI27Asc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=xJuhmu3HtKJbvwZ5p8fGj/7WlTfQYwf1ilg0GqkijvvDgSVX6ybll6MQkr5rs+oXSY
         9LgVIfn3TtFQySi5gb/AR4YVTBs/6XffCdk8xqgWKNzYU02uJ33s79YeXVgOshDNDXW7
         RxHhb8PrIZjazqC640+dOqyia7wO1aAmSHiS4=
Received: by 10.223.144.77 with SMTP id y13mr6652100fau.86.1273602431045;
        Tue, 11 May 2010 11:27:11 -0700 (PDT)
Received: from rechenplan.localnet (brln-4dba81cc.pool.mediaWays.net [77.186.129.204])
        by mx.google.com with ESMTPS id u12sm27767672fah.4.2010.05.11.11.27.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 May 2010 11:27:09 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.33-02063303-generic; KDE/4.4.75; x86_64; svn-1124099; 2010-05-04)
In-Reply-To: <4BE7A629.7050709@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146904>

On Monday 10 May 2010 08:22:33 Johannes Sixt wrote:
> Am 5/8/2010 18:39, schrieb Andreas Hartmetz:
> > On Friday 07 May 2010 09:20:15 Johannes Sixt wrote:
> >> But what is wrong with "start-point"? It precisely conveys the meaning
> >> of the parameter.
> > 
> > Look at -f: as far as I understand it moves the branch *head*, so
> > start-point is plain wrong. The "root" of the branch is not moved, or
> > only moved indirectly (not sure if the latter is allowed).
> 
> Huh? The purpose of -f is not to *move* a branch head, but to say "trust
> me, I know what I'm doing". Why would "start-point" not be suitable in
> this case?
> 
Because a branch doesn't start at the head.
