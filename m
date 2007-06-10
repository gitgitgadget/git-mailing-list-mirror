From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 23:36:57 +0200
Message-ID: <e5bfff550706101436y2f842521hc8725b1787b7f8f9@mail.gmail.com>
References: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com>
	 <200706101704.51374.ismail@pardus.org.tr>
	 <e5bfff550706100736v110055acn8ecca19f5c3f5cff@mail.gmail.com>
	 <200706101933.36760.ismail@pardus.org.tr>
	 <20070610175628.GI4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Ismail_D=C3=B6nmez?=" <ismail@pardus.org.tr>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:37:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxV5s-00069J-On
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbXFJVg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755465AbXFJVg7
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:36:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:57779 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbXFJVg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:36:58 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1862917wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 14:36:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d5rXSgLsqUO4mZkBTKw2Nubw4kbvh2VZYHOhusp9QqBPlXovakvdLxJtcaRg1rPpo+GrDqwZDJse4M0725y8wvdq2f3KRSr2w8f1lwpOVXJ9A4fwxbly9iOHZn5qg+kEqTUlb/mNjfVHWXL0XfaATmQZ8JIXwKohkufd+YR+Spc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MSFyvqKVG7/IUtlIxEJLpLpcA4nFh9ZsQRP4kUfxwGOQRM4EAxxaN7dDNqFTrwcyWQDbbe9B333ySC6yihQXxzX3Q7cRvcfFKAPBKiMdGrkfS5Tc09iAIaSlFN4yCM4JJ/Del1DAPHzk7p5FyOpFh4UOk7BrhjttDyUc47ur7Qs=
Received: by 10.114.181.1 with SMTP id d1mr4894933waf.1181511417859;
        Sun, 10 Jun 2007 14:36:57 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 14:36:57 -0700 (PDT)
In-Reply-To: <20070610175628.GI4084@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49772>

On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
>
> On another side, is there a measurable compilation time improvement with -frepo?
>

No, compilation time is indeed much slower with -frepo, theoretically
we should gain something in bin file size.

But anyway I have removed the option from CXXFLAGS as suggested by
Ismail and pushed the patch. It will be included in rc2.

Thanks a lot to Ismail reporting and fixing and to you for explaining the stuff.

Marco


P.S: In case someone is interested I have found these docs
http://gcc.gnu.org/onlinedocs/gcc-4.2.0/gcc/Template-Instantiation.html#Template-Instantiation
