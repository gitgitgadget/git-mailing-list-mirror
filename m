From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v4 7/8] update-ref: support multiple simultaneous updates
Date: Wed, 04 Sep 2013 15:16:57 -0400
Message-ID: <52278729.2060404@kitware.com>
References: <cover.1378142795.git.brad.king@kitware.com> <cover.1378307529.git.brad.king@kitware.com> <ad27a96b70198e837ac61995a1328960e10072bc.1378307529.git.brad.king@kitware.com> <xmqqk3iwmm6l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 21:18:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIbR-0008NM-57
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760421Ab3IDTSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:18:53 -0400
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:50158 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756904Ab3IDTSw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Sep 2013 15:18:52 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUieHnJsLcCpi9RJS0IAR1JzlJsyj5een@postini.com; Wed, 04 Sep 2013 12:18:52 PDT
Received: by mail-oa0-f51.google.com with SMTP id h1so1009538oag.38
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 12:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=PcRBywJxgyLHyyYhel0R4suLKEosb09Qq7XNRHOU4ow=;
        b=JfCHqiJZ2hVkJwm/niD+xVNi7hJfB6SVgqP0eqN3/T6iMb+ZviXSyxfE9qzj7/EQG6
         NNC+b5ZPBasn6MGIBVzWFME+mFGtn4+C2qp7eRTT8SUmL5B2qCZp8Or7gCwSsJC6zFtQ
         HS/OtettTel1we9ZJmS0KLzRjoWdVtuSAEUGuAtyCTN61Dg0Nu547x8HpgzXlmPTnwZf
         8O5wbgsgIErlpRKNNYVrypzfXM9NDCbkbpTinb8rbNR3FNnYjV+dyiN24GmgZ3pmeQwM
         PODPzpCtTNmQHasJUwsqdcvDwTKPgfPWenPHlr4AYkbpbqQpZrmUMvTzthFU2oFs/Yhk
         040w==
X-Gm-Message-State: ALoCoQlfx9zWt3WeGS6jgBeUi9PgNuhvYK7ojgK4wgCqY2T59NnWWCqOMKcIimEu5XkJrtRbShsvw1UpZOfcUz5cWG1VZ4MWb6PGUMlwMDNnldZ4uanhIyJTwca6TpaAoty0PrUpDpEHnVyDT69PXZopJagH85L4AQ==
X-Received: by 10.60.173.205 with SMTP id bm13mr3375362oec.25.1378322331697;
        Wed, 04 Sep 2013 12:18:51 -0700 (PDT)
X-Received: by 10.60.173.205 with SMTP id bm13mr3375355oec.25.1378322331611;
        Wed, 04 Sep 2013 12:18:51 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id nw5sm25272155obc.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 12:18:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqk3iwmm6l.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233866>

On 09/04/2013 03:17 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> +static void update_refs_stdin_read_n()
>> +static void update_refs_stdin_read_z()
> 
> These need to be defined with explicit (void) argument list.

Oops, fixed.

Thanks,
-Brad
