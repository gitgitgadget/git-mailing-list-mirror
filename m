From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Should "git apply --check" imply verbose?
Date: Tue, 20 Aug 2013 14:59:50 -0400
Message-ID: <5213BCA6.9040501@windriver.com>
References: <5213873A.6010003@windriver.com> <xmqqioz06y9m.fsf@gitster.dls.corp.google.com> <5213B95D.3040409@windriver.com> <20130820185127.GG4110@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:02:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrBv-0004Vu-Id
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273Ab3HTTCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:02:02 -0400
Received: from mail.windriver.com ([147.11.1.11]:45363 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab3HTTCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:02:01 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r7KIxhWl015649
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 20 Aug 2013 11:59:43 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.2.342.3; Tue, 20 Aug 2013
 11:59:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130820185127.GG4110@google.com>
X-Originating-IP: [128.224.146.65]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232632>

On 13-08-20 02:51 PM, Jonathan Nieder wrote:
> Hi Paul,
> 
> Paul Gortmaker wrote:
> 
>> OK, so given your feedback, how do you feel about a patch to the
>> documentation that indicates to use "-v" in combination with the
>> "--check" to get equivalent "patch --dry-run" behaviour?
> 
> Sounds like a good idea to me.
> 
> I assume you mean a note in the OPTIONS or EXAMPLES section of
> Documentation/git-apply.txt?

I hadn't looked exactly where yet, but wherever makes sense and
wherever appears in TFM.

P.
--

> 
> Thanks,
> Jonathan
> 
