From: "Stephen Robin" <stephen.robin@gmail.com>
Subject: RE: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Wed, 18 Mar 2015 08:38:09 -0000
Message-ID: <000701d06156$dd3145e0$9793d1a0$@gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
	"'Duy Nguyen'" <pclouds@gmail.com>
To: "'Paul Tan'" <pyokagan@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 09:38:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY9US-0001pX-Cx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 09:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbbCRIiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 04:38:07 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34881 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbCRIiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 04:38:05 -0400
Received: by wibdy8 with SMTP id dy8so83671095wib.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-type:content-transfer-encoding:thread-index
         :content-language;
        bh=VVKyyLy6nTBm8bzWXe5EYcovsNcHkCcKAw4zB8ZJofI=;
        b=LxehqXmYgtbn1/2JqVUINkcfO53Oytr/txsKLzLASuwP4UJ9Xe/gXjbo4ddxrPa10m
         hwNb5Zl9N4KolKPvpUB8wjyBdtwiAON1euV4UjznlsiS2mAjYE+BQ19gJfF/YarASnzo
         xVnBkOPc5sUshJm/4Ev5Mmh5Uu4cglN4N9PYXT3v/U2KcyCXxuXCAHGKWdNCHRChBDn9
         MdWdA0SzrpqnIe7LAdpt7WLasv78h7NsbUbvkvTLJQvjnNsEGeqbHqXMifwT/xWGnSeM
         4U6qOpF/p8iHZdmmPKkudhuvjvrM/1rlXqtmIf0SglYPY8qKi+g6mUrOzbXLRtY3pgfA
         S1cQ==
X-Received: by 10.180.11.180 with SMTP id r20mr4791665wib.36.1426667883926;
        Wed, 18 Mar 2015 01:38:03 -0700 (PDT)
Received: from StephenFlaptop ([141.0.152.225])
        by mx.google.com with ESMTPSA id a13sm23425054wjx.30.2015.03.18.01.38.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2015 01:38:03 -0700 (PDT)
In-Reply-To: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMbyJILp4mrvYyi6lhr0guzQYfa1pqLF5ow
Content-Language: en-gb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265697>


> Paul Tan writes:
> I would like to share this very rough prototype with everyone. 
...
> I started this as a just-for-fun exercise to learn about the git internal
API

I started to rewrite git-pull for similar reasons a couple of months ago,
but I haven't had time to complete it.  It looks like my version has less
work remaining than yours, would you like me to share it?

> Finally, there is the possibility that in the process of conversion bugs
or incompatible behavioral changes may be introduced which are not caught by
the test suite. Ideally, I think the solution is to improve the test suite
and make it as comprehensive as possible, but writing a comprehensive test
suite may be too time consuming. 

This is why I haven't had time to finish and submit my patch.  While the c
code is pretty much complete, I felt the test suite needed some extension
before I could be confident the new code is correct.
