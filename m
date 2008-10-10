From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2] gitweb: refactor input parameters parse/validation
Date: Fri, 10 Oct 2008 19:33:40 +0200
Message-ID: <cb7bb73a0810101033y3741df2dy88a64e72cbc3b8b0@mail.gmail.com>
References: <200810071257.38423.jnareb@gmail.com>
	 <1223457985-27094-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <20081010150108.GC29829@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 19:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoLt8-0003Pm-HC
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 19:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056AbYJJRdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757993AbYJJRdm
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 13:33:42 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:54413 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757864AbYJJRdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 13:33:41 -0400
Received: by el-out-1112.google.com with SMTP id z25so295076ele.1
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UGt+FlDT1FBhEIdYbP+Bv4e95HnAehfbDw4Kyxowzgc=;
        b=VaY5bz5wwF0j3cHVU5mF4JIRza2ichbKX1PP9rb0fnXgeL8N64F20VqHjlZf/MfQJa
         HlDMO1K6Aytgiu+xnI3jVw+GpwaBkhECEySzfry+C8jY8FyS2qJ6bjbFGIRd3VbqNcB+
         KIwEsnAO8bfPRGdoKvHwprc4nVU4BfNwC3FOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=CmxKvXkS1MvsUhGMY4QbYQ1b97te+q7RED6NdTBP5D9PcFzh5S5GyGsiRijHzWCa5w
         CPtbTrflJ2YU/x4XINkMm8PQVs/722oaJYXph9th02lSVUWD3rB3jeF1qcVjzbmffb+j
         ZGFS1r9sAhAVgjXTF4V78pgV51w9ndw2t536w=
Received: by 10.150.230.15 with SMTP id c15mr2617704ybh.28.1223660020770;
        Fri, 10 Oct 2008 10:33:40 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Fri, 10 Oct 2008 10:33:40 -0700 (PDT)
In-Reply-To: <20081010150108.GC29829@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97951>

On Fri, Oct 10, 2008 at 5:01 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
>> +sub validate_action {
>> +     my $input = shift || return undef;
>> +     return undef unless exists $actions{$action};
>> +     return $action;
>> +}
>
> Shouldn't $action here be $input?

Urgh. Yes, yes it should. Good catch. Should I resend?


-- 
Giuseppe "Oblomov" Bilotta
