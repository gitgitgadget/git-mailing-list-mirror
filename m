From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/12] MINGW: config.mak.uname: drop USE_NED_ALLOCATOR
Date: Mon, 28 Apr 2014 09:30:09 -0700
Message-ID: <20140428163009.GC13002@google.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-11-git-send-email-marat@slonopotamus.org>
 <CABPQNSZD5jz1A8=zQvU4dYvNb-5M+TV50Uj+oVbWJs3YWBytHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoRk-0007zW-AS
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbaD1QaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:30:14 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35390 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903AbaD1QaM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:30:12 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so12468pad.20
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/6x3CSaqFB0Mv9k/zdCuAv11e/uxyybUifESOD7SJHc=;
        b=Hhx9cOOBsPHQ1L8d5H/DMO+FfDZ1qEJT6yi+C/CbQGWdL46c3QkHlxezxECEGwM1RG
         jsqLXipoYm4Dfhxcscen+fQUpQmVh/LkDlfvJ5WJqrZecz2YskVf+ClTL0PVsD8zJroD
         SvekPyt5nGGsFffe7esMRCt/XgXYbcUPLiXRZ5+9STupdLzDEAtnPeORfwJuX40coRzt
         97jbC1Un7tjKOt4Tq7fHP4fpHaX88qXfTrEAF+H7k20cLDrmmAcs7QcP/gxeNtTcQDNr
         BCBcBY23r+nSKo7TzLNegOUhxi7WbqYnDyF0S3XrTvTnfi97y1Kzg0jUmsTiHPpPcem+
         y1Gw==
X-Received: by 10.68.202.74 with SMTP id kg10mr4049079pbc.163.1398702611886;
        Mon, 28 Apr 2014 09:30:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iq10sm36043417pbc.14.2014.04.28.09.30.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 09:30:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABPQNSZD5jz1A8=zQvU4dYvNb-5M+TV50Uj+oVbWJs3YWBytHw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247378>

Erik Faye-Lund wrote:
> On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:

>> nedalloc was initially added in f0ed82 to fix slowness of standard WinXP
>> memory allocator. Since WinXP is EOLed, this point is no longer valid.
>>
>> The actual reason behind this commit is incompatibility of malloc.c.h
>> with MinGW-W64 headers. Alternative solution implies updating nedalloc
>> to something newer.
>
> Did you measure that malloc on newer Windows-versions are actually
> faster? AFAIK, malloc does a lot more inside the CRT than in the
> kernel...

If it does turn out that nedalloc is not needed any more, please
remove it from compat/, too. ;-)

Thanks for cleaning up.

Jonathan
