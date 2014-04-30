From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 15:14:07 -0500
Message-ID: <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:24:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfb3j-00030b-7S
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759530AbaD3UYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:24:47 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:60377 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758905AbaD3UYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:24:45 -0400
Received: by mail-yk0-f172.google.com with SMTP id 131so1978908ykp.17
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=IC01G2MvqFnW/iMbvc0IXjgUL05idBt23GVhsfz3zkY=;
        b=SFY2gKruZGwy7bnMMcTJinRpvPhsNILYgw6dolQThbtN5T1F6TAw57WlIOo+V6uS7w
         t6byUHLkChlPX8FdCW+NJos9kE+UdWKRHVeCOtrMEFFZIs5UGbjK4GeFkBC5Yqt7doTs
         X42CwxqZK7gGQ7aiiERLzBTo4bDddft16LlCNzc8V8/tYzZYBpsZGIz2uKOY4uj+9jrQ
         nfz3uSYURAYrmFH8HxGwaLkBIT1+sw54TVO8gXwgTcS2T6Byci5s5EeJCKeghoe6FhSk
         zM49GrJuyKKNaEjTkjpWVW2uuIw+9ViZMuZqVuhGLJXbHkOxZYuEvp+AYX3AhRNYuxnw
         0tLQ==
X-Received: by 10.236.199.212 with SMTP id x60mr9184451yhn.90.1398889484716;
        Wed, 30 Apr 2014 13:24:44 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d43sm8348752yhb.10.2014.04.30.13.24.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 13:24:43 -0700 (PDT)
In-Reply-To: <536152D3.5050107@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247776>

Marc Branchaud wrote:
> All that said, I don't object to any attempts at improving the command
> either.  But I also don't see any kind of improvement that would lead
> me to start using "git pull" let alone recommending it to new users.

What is wrong when `git pull` merges a fast-forward? The problems with
`git pull` come when you can't do a fast-forward merge, right?

-- 
Felipe Contreras
