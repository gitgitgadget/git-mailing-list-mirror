From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: git command to read
Date: Tue, 21 Oct 2008 16:06:35 +0400
Message-ID: <bb6f213e0810210506u51cb83d4p718b793b3e9f7fca@mail.gmail.com>
References: <18685.47909.354146.487700@cargo.ozlabs.ibm.com>
	 <20081021112521.GC17363@coredump.intra.peff.net>
	 <18685.49368.557513.727997@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	git@vger.kernel.org
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 14:09:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsG1f-0005NV-AJ
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 14:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbYJUMGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 08:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbYJUMGi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 08:06:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:34584 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbYJUMGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 08:06:37 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1151051nfc.21
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eqEUUHaTuA3OtK3qX58+JoSNEKyjN7uw8jIV6cZcFNM=;
        b=Ft11NFp4CAWSAJHfptXjwJtNGSuuW8EZmNtC+BCwqd3NlsuhkamT1jLx8tqhqSP+YO
         YOWVeIqeUGGIqKKwbAa8gst+i7sQbjuFuM2CfHUxR6YfH6E4VuesboILXZp5HVhDAOOq
         NztmhyZjx2WWgPzqOW+w1MvaOp5T6fHUkryEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DwaV+RWLzp2k+AUWx3HeIDWuL80cHQuRz+hv/J33rl5ssN8AV981Zb7rcO1DO+Qw0O
         8WtGeF/EONk9K7TAaKjG0bV1BeM6ljkyMVHoo6ltCsjxLYKSmkGy9zyOja4TdPHSZ5in
         56t0NLztcVoaZzQYvLujda0ypQ6WBJ2yplkqE=
Received: by 10.103.192.10 with SMTP id u10mr4441513mup.29.1224590795368;
        Tue, 21 Oct 2008 05:06:35 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Tue, 21 Oct 2008 05:06:35 -0700 (PDT)
In-Reply-To: <18685.49368.557513.727997@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98783>

On Tue, Oct 21, 2008 at 3:45 PM, Paul Mackerras <paulus@samba.org> wrote:
> Jeff King writes:
>
>> On Tue, Oct 21, 2008 at 10:21:09PM +1100, Paul Mackerras wrote:
>>
>> > Is there a command in git at the moment that will read commit IDs on
>> > standard input and print the contents of each commit on standard
>> > output (without waiting for EOF on stdin)?
>>
>> How about:
>>
>>   git cat-file --batch
>>
>> ?
>>
>> Unfortunately it just dumps the raw commit information instead of
>> allowing the usual formatting, but perhaps that is sufficient (you asked
>> for "contents").
>
> Ah, thank you, that looks like just what I want. :)

Since cat-file does not perform any encoding conversion, you'll have
to process the encoding headers manually though.

Alexander
