From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Wed, 20 Mar 2013 11:35:38 -0700
Message-ID: <20130320183538.GM3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-3-git-send-email-artagnon@gmail.com>
 <20130320182213.GI3655@google.com>
 <CALkWK0nu5oMw-+uh8mLRUOyAFoETUpKZfYuO2LLJAgF0+XHpRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINru-0006O8-Sa
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755269Ab3CTSfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:35:44 -0400
Received: from mail-da0-f54.google.com ([209.85.210.54]:41793 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3CTSfn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:35:43 -0400
Received: by mail-da0-f54.google.com with SMTP id p1so1143362dad.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=whoVGVrBgZjmcXxOYse+LvU7Wxgt6HidlSPsqk7Gbbw=;
        b=uyjiUViYiFxwopKX03ewe72aZjGZ+WzyyPuyb9vyGEzhVYPFz4pe2T7WzQNqdzwrvc
         NPvaOdPyaH81ExmMXJEChzNlIAfzpi6hkvJc71hUAjsnmSvW0WFCkgPTdhmST7bWvMTS
         vAR173tSCmYaWA33F9/+cm/z8Qoo86WRt9a0x6YxAwPZdIlZ4qAX86qohQ/5DAuabRsd
         0xLCp02I1K4lVe4SkJSzW7lAdyFQA4vZ5a0jXLHNukoVIFGe9i+j4yo/Qxt+eMaVY7OH
         yAi2wsn0qJqqPBymaKL10/6N35v125UtAnr32pMcMN06hUkQQFpMVh72UgBmWu2LWu9I
         XloQ==
X-Received: by 10.66.217.133 with SMTP id oy5mr6328579pac.20.1363804543082;
        Wed, 20 Mar 2013 11:35:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id xz5sm2965848pbb.25.2013.03.20.11.35.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:35:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nu5oMw-+uh8mLRUOyAFoETUpKZfYuO2LLJAgF0+XHpRA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218645>

Ramkumar Ramachandra wrote:

>      When I want to add a test for branch.<name>.pushremote, I grep
> for branch.*.pushurl, and open files with sensible names; I'm not
> going to open up the file and read a long description of what tests it
> already contains.

Huh?  The test_description is output for "./t5516-* --help" and is
supposed to help people hacking on the test to understand its setup
and its purpose.
