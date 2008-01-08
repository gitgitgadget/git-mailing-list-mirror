From: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 13:15:37 -0800
Message-ID: <7vy7b0qarq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site> <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de> <20080108172957.GG22155@fieldses.org> <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de> <20080108205054.GN6951@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>,  "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>,  Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,  Robin Rosenberg <robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@public.gmane.org>,  Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>,  Peter Karlsson <peter-wzhfs8O2nkI+/KzbbBz5qQ@public.gmane.org>,  Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,  msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Tue Jan 08 22:16:32 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.168])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCLoD-0008AT-QG
	for gcvm-msysgit@m.gmane.org; Tue, 08 Jan 2008 22:16:30 +0100
Received: by py-out-1314.google.com with SMTP id p69so2314605pyb.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Jan 2008 13:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=Gr2Uc6qe4xI+yfXU3kN38hZMflW6UABdeGOgG6dRW+U=;
        b=fNz3Ptko/5TIH/rXQGJLO2prXWOnIM75Kmus55EUbHeXPv5MtBEW/IbWpuBH7Xob39Y63gDHVcycmqZAQZ8wTB3s/CjixMPfr8HfEfSGY84eHBILfyKYVoHc8N+n21k49YlvBYKq6llqhs3aBaBNSiozjl9edC7haCs9SDMHSD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=X9IWlfNR3w9994CzNUa9br1exXZboVIlpOjNSvsEsvp7t61QQysOgSnKkeC27gIhUs90gOe6ZB17+u25iVN+L6FK6kzjyO1vqsA+V2PtAiTVEx2nTNNXHf/Qo8hUgRjjk6Ji2ILshTgEORMuM+0dBihgmxklqH889wRON52EtwU=
Received: by 10.151.8.8 with SMTP id l8mr463751ybi.3.1199826962567;
        Tue, 08 Jan 2008 13:16:02 -0800 (PST)
Received: by 10.44.219.52 with SMTP id r52gr1334hsg;
	Tue, 08 Jan 2008 13:16:02 -0800 (PST)
X-Sender: gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.114.47.10 with SMTP id u10mr366538wau.3.1199826962331; Tue, 08 Jan 2008 13:16:02 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com [208.72.237.25]) by mx.google.com with ESMTP id h71si29247348nzf.3.2008.01.08.13.16.01; Tue, 08 Jan 2008 13:16:02 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) client-ip=208.72.237.25;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org designates 208.72.237.25 as permitted sender) smtp.mail=gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org
Received: from a-sasl-quonix (localhost [127.0.0.1]) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CB4921B2; Tue,  8 Jan 2008 16:16:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5872F2187; Tue,  8 Jan 2008 16:15:49 -0500 (EST)
In-Reply-To: <20080108205054.GN6951-EQL4cN526mwi5CQI31g/s0B+6BGkLq7r@public.gmane.org> (Dmitry Potapov's message of "Tue, 8 Jan 2008 23:50:54 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69923>


Dmitry Potapov <dpotapov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On Tue, Jan 08, 2008 at 07:58:57PM +0100, Steffen Prohaska wrote:
>> 
>> I don't think a solution will be found by declaring one platform
>> native (UNIX) and all other platform non-native.  The question to
>> answer is how to support cross-platform projects.  A valid
>> solution should never corrupt data unless the user explicitly
>> told git to do so.  I don't believe it is a valid solution to set
>> core.autocrlf=true on Windows and tell the users: "Well, in its
>> default settings, git sometimes corrupts your data on Windows.
>> Maybe you want to switch to Linux because this is the native
>> platform where data corruption will never happen."
>
> Maybe I am wrong but it seems to me that to guarantee that
> CRLF conversion is reversible (which means that you can
> always get exactly what you put into the repository), it is
> enough to check that the conversation is performed only if
> every LF is preceded by CR.

I've heard that before but I seem to recall convert.c already
doing something similar if I am not mistaken.

static int crlf_to_git(const char *path, const char *src, size_t len,
                       struct strbuf *buf, int action)
{
	struct text_stat stats;
	char *dst;

	if ((action == CRLF_BINARY) || !auto_crlf || !len)
		return 0;

	gather_stats(src, len, &stats);
	/* No CR? Nothing to convert, regardless. */
	if (!stats.cr)
		return 0;

	if (action == CRLF_GUESS) {
		/*
		 * We're currently not going to even try to convert stuff
		 * that has bare CR characters. Does anybody do that crazy
		 * stuff?
		 */
		if (stats.cr != stats.crlf)
			return 0;

		/*
		 * And add some heuristics for binary vs text, of course...
		 */
		if (is_binary(len, &stats))
			return 0;
	}

It counts CR and CRLF and converts only when there are the same
number of them.  You probably only need to make it also count
LF?
