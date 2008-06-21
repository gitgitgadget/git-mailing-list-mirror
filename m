From: "Jim Raden" <james.raden@gmail.com>
Subject: Re: MinGW port pull request
Date: Sat, 21 Jun 2008 17:21:47 -0400
Message-ID: <5fc54b450806211421m64eee6e5l3622243e65f633a2@mail.gmail.com>
References: <485B6510.3080201@viscovery.net> <7vskv79l37.fsf@gitster.siamese.dyndns.org> <200806212318.47745.johannes.sixt@telecom.at>
Reply-To: james.raden@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative;  boundary="----=_Part_13256_25410209.1214083307807"
Cc: "Junio C Hamano" <gitster@pobox.com>, msysGit <msysgit@googlegroups.com>,  "Git Mailing List" <git@vger.kernel.org>
To: johannes.sixt@telecom.at
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Jun 21 23:22:48 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAAXn-0000kX-Au
	for gcvm-msysgit@m.gmane.org; Sat, 21 Jun 2008 23:22:47 +0200
Received: by yw-out-2122.google.com with SMTP id 8so6576970yws.63
        for <gcvm-msysgit@m.gmane.org>; Sat, 21 Jun 2008 14:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:to:subject:cc:in-reply-to:mime-version:content-type
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=6wONJqxNjebLT2P7doMIia0kJgiJ5DDKwvQW4c8iI3g=;
        b=dujc4lpWNnHoLD/Pw0D0XdnJwmtw1XIE/4seBffPeUaUHWtjHNTQ8zyXBK1cHV1LX0
         bTo36tB2XoUMDl4MjB4qqbYaP9YrtYzD99JnqUySiZm17Y5tEUM7tlYXMzbn7scap3y0
         DBhQK18s36gug7AfsiTTMV3c7unz/HrvClLHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:to:subject
         :cc:in-reply-to:mime-version:content-type:references:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=Qxs5kC7ZxfQ8tA+q1GtqGQMlysQbuct71smnMNR5GfhLZt6PYQV+CHOZGp7vMVPR4E
         9hZg+qdjo/IdojLClXl4j2eGmimlJE4LBNh4wIT2kmd0KbrAhJjpGr9rUTc7arkX9Ocb
         VeRgqnu4x7yf7+9+5DgHzocouZNjVZiZNoONM=
Received: by 10.141.137.3 with SMTP id p3mr884983rvn.17.1214083309402;
        Sat, 21 Jun 2008 14:21:49 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2404prm.0;
	Sat, 21 Jun 2008 14:21:49 -0700 (PDT)
X-Sender: james.raden@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.120.14 with SMTP id s14mr5736466agc.3.1214083308871; Sat, 21 Jun 2008 14:21:48 -0700 (PDT)
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235]) by mx.google.com with ESMTP id z53si4331485pyg.1.2008.06.21.14.21.48; Sat, 21 Jun 2008 14:21:48 -0700 (PDT)
Received-SPF: pass (google.com: domain of james.raden@gmail.com designates 209.85.198.235 as permitted sender) client-ip=209.85.198.235;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of james.raden@gmail.com designates 209.85.198.235 as permitted sender) smtp.mail=james.raden@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by rv-out-0506.google.com with SMTP id f6so7852589rvb.51 for <msysgit@googlegroups.com>; Sat, 21 Jun 2008 14:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to :subject:cc:in-reply-to:mime-version:content-type:references; bh=voG9QfgLiFpye4M8ZH8AaUDvNcpTKtEC9nqzvBsh5w8=; b=iG8LlpUm2F1cCbIjG3njrnvzMEqMTAsYKQHU1+Ci/qlX/API8LNhJEQ9PmkfKX80Yb Wik5bjsouc39JkOiHGeyIQHs3+gKMGNIcFzT5Ysii8/tcBqMdB+p4GQcQ5we4Z2HG/GJ f8DmauxRxlS1Dn8cZXfG6WCBKcWXqSICJZDuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version :content-type:references; b=MOpcV0/gdfRmJoHpfLTlQFyvmVe2pEJu6qnvoyWhEokJP/zw+59sd5aw43J/Se5yg8 FE4edafILLQv3f+FflRD2NnrZnhJvVpueLZGLSubWkgTI07ITuimwNSKFvwjjzzX25AD W+LFxYU9U27XDxv3eA9BkmGJyqqYEdr+OxhVM=
Received: by 10.141.62.15 with SMTP id p15mr9979270rvk.144.1214083307855; Sat, 21 Jun 2008 14:21:47 -0700 (PDT)
Received: by 10.151.103.10 with HTTP; Sat, 21 Jun 2008 14:21:47 -0700 (PDT)
In-Reply-To: <200806212318.47745.johannes.sixt@telecom.at>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85726>


------=_Part_13256_25410209.1214083307807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Jun 21, 2008 at 5:18 PM, Johannes Sixt <johannes.sixt@telecom.at>
wrote:

>
> >  * There are still too many ifdefs.  I am wondering if the changes to
> >    pager and process stuff is easier to manage in the longer term if they
> >    are made into completely separate files (i.e. instead of linking
> >    pager.o you would link mingw-pager.o).  I dunno.
>
> I think that would not be helpful. Both parts need to be maintained,
> whether
> they are in the same file or in different files. If they are in one file,
> and
> someone needs to make a change, then there is a chance that a corresponding
> change is made in the MINGW32 arm. If not then there is another chance that
> the person would at least say "I don't know how to do it for MINGW32". But
> if
> you separate the implementations completely, then both chances are missed
> much easier.
>
> I quite agree!!

------=_Part_13256_25410209.1214083307807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Jun 21, 2008 at 5:18 PM, Johannes Sixt &lt;<a href="mailto:johannes.sixt@telecom.at">johannes.sixt@telecom.at</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><br>
</div><div class="Ih2E3d">&gt; &nbsp;* There are still too many ifdefs. &nbsp;I am wondering if the changes to<br>
&gt; &nbsp; &nbsp;pager and process stuff is easier to manage in the longer term if they<br>
&gt; &nbsp; &nbsp;are made into completely separate files (i.e. instead of linking<br>
&gt; &nbsp; &nbsp;pager.o you would link mingw-pager.o). &nbsp;I dunno.<br>
<br>
</div>I think that would not be helpful. Both parts need to be maintained, whether<br>
they are in the same file or in different files. If they are in one file, and<br>
someone needs to make a change, then there is a chance that a corresponding<br>
change is made in the MINGW32 arm. If not then there is another chance that<br>
the person would at least say &quot;I don&#39;t know how to do it for MINGW32&quot;. But if<br>
you separate the implementations completely, then both chances are missed<br>
much easier.<br>
<br>
</blockquote></div>I quite agree!!<br>

------=_Part_13256_25410209.1214083307807--
