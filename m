From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Mon, 12 Apr 2010 09:25:04 +1000
Message-ID: <776480BE-3652-489A-96C9-9312321E49C0@gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com> <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234> <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com> <d0869259b375a26df46ef92a2b973615@212.159.54.234> <p2ofabb9a1e1004111050x660c37fdke4d5316baaa0cfbe@mail.gmail.com> <q2i2cfc40321004111522kd177fb89k6b9265c641d7deec@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 01:25:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16X1-0000Tm-2D
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab0DKXZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:25:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57484 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753129Ab0DKXZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 19:25:20 -0400
Received: by gwj19 with SMTP id 19so672189gwj.19
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=fVGSfq2AQVuoOzucvq2ZUQNse8zJexnt958DXG1Ze+U=;
        b=rFEFd3rRLgtAthMByqhyBtKvx9PtUNth5ixh0z/yirNBCsTMotQSCrXTmuFAYeLqi8
         GvNi/AK2XTwJbs8kAAEQ4izgekjqom1qa0A1a32oNF5xzQE//CmStTiClM79KlPtyvyi
         xa+2zCnpv6FIRzlBSBfkLzpatGSEoZM9CTrh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=ZZv2ma3EKJGfV1oumFIL4JvD82eLoV3R65rZJZGxA10qWVEMB+5d7RbYaf3Sv6E0UU
         ZpHkFpmZFrNOS6vgq3tHRlLcSWwnjiAdi4JEyHfJ9gx9KqeizWbZdgoap7kYDV59jsxV
         eaaMppnwHtgsKS3BFe1eUEuoPjS7ZYbwr0jlY=
Received: by 10.90.172.1 with SMTP id u1mr1515620age.66.1271028319500;
        Sun, 11 Apr 2010 16:25:19 -0700 (PDT)
Received: from [10.248.112.151] ([58.171.184.204])
        by mx.google.com with ESMTPS id 7sm957815ywf.40.2010.04.11.16.25.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Apr 2010 16:25:18 -0700 (PDT)
In-Reply-To: <q2i2cfc40321004111522kd177fb89k6b9265c641d7deec@mail.gmail.com>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144697>



On 12/04/2010, at 8:22, Jon Seymour <jon.seymour@gmail.com> wrote:
>
> So, would it be worth providing a hint as to record type in the
> output_start_object call so that if it was later desired to subsume
> line-oriented formats under the same framework, there is enough
> information available to the backend to do that?

Of course, one way to do this would be to use a more descriptive  
record name than "entry". This would make the record itself (as  
opposed to just it's fields) self-describing.

The point is, you would want to start using descriptive record names  
now so that you don't end up locked into a partially context sensitive  
base of consumers who are expecting their JSON records to be called  
"entry" and using context hints to infer the actual record type.

jon.
