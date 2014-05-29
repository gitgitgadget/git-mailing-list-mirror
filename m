From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 13:07:34 +0200
Message-ID: <1401361654.26905.2.camel@spirit>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rodrigo Fernandes <rtfrodrigo@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 13:07:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpyBT-0000UX-Hk
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 13:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbaE2LHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 07:07:39 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:58695 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbaE2LHj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 07:07:39 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so209057wes.32
        for <git@vger.kernel.org>; Thu, 29 May 2014 04:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=K9rGMBqzif3wF7ygNO1MjBNFEgEx02a+CKvr45KYwFA=;
        b=Pl+i59/0olS+h3zqcSa5Kk5agflilWEzSA97KZveUfOh6Vj1crl5YboK8QsLrIV6/o
         lJWSgfE1CO0Q6cNI9bpixeJrVYhU3SlLFOjVqeKnNEYd6HpBADG6d1s/jqdGGGMjsqLg
         HxTQLQW9HZANnFJTG0HHG5mKwDopwwoxHv3PPKpbzYGwOTr1Uxa1PWFQByDJVONKlmge
         4H7RvQYsS1yLvpW5xy3n/sIxc34YW1u2a3hN8xGSVPQ0IQaTSex+gLMk5XdbLgK16WHR
         SDb9Q05NYIoBHcdEich/cpaQ6XXbuBIu3t6TTQpelalIbhlgG8fjqWXTC2aJjfvsk2by
         afTw==
X-Gm-Message-State: ALoCoQkvGjeeXgJYfBGwcomUwmnZNVh/HQUJGdm7oReXlVXSU5Y/jm7GYOUaxrsaq67LTJpKCNW4
X-Received: by 10.195.17.169 with SMTP id gf9mr9875604wjd.10.1401361657712;
        Thu, 29 May 2014 04:07:37 -0700 (PDT)
Received: from [10.42.1.3] (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id lo18sm1992859wic.1.2014.05.29.04.07.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 May 2014 04:07:36 -0700 (PDT)
In-Reply-To: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250360>

On do, 2014-05-29 at 11:29 +0100, Rodrigo Fernandes wrote:
> 
> The problem happens when I try to get a pretty log for a commit with a
> wrong date.

The commit is:

===
$ git cat-file commit e9dddaf24c9de45d9b4efdf38eff7c30eb200f48
tree d63aeb159635cb231e191505a95a129a3b4a7b38
parent 9276202f1c0dcc360433df222c90f7874558f072
author SamWM <sam@webmonkeysolutions.com> 1288370243 --700
committer SamWM <sam@webmonkeysolutions.com> 1288370243 --700

Update version number, make text formatting and indentation consistent
with the rest of the code
====

Those dates are indeed wrong, I'm not surprised git refuses to parse
them.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
