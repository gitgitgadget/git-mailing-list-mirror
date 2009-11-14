From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sat, 14 Nov 2009 21:35:31 +0100
Message-ID: <7d4f41f50911141235r29f791a0u72cc45b6d94c8f6e@mail.gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
	 <fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com>
	 <7d4f41f50911141129n967374ap7d92296c5723e31e@mail.gmail.com>
	 <fabb9a1e0911141138r5279650ge57db2413e2321a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 21:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9PSM-00015l-3P
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 21:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbZKNUf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 15:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbZKNUf1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 15:35:27 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:47557 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbZKNUf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 15:35:26 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1379224eyd.19
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 12:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=lLwG1mNQi7FdYX5ZZQiJJOAfTToIw3kgLNObh1fERJg=;
        b=QPZm3Fq2vu0fO3iB1g+ROM/sEohHdlaP5nntIhcY04ch+4sSySdahNcSMqI9S58svG
         yc+iusXq/HdL9N6eveTuoWPri9PClgTatDz4C5yv6Xw65GT6PPjKR/fucKbHLXlNP0IV
         iX4a3+6gZ7H7EVmO99vrAi1I/kNNeDyOp32KU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=n6hEMMoGRRol/nk6bZwBxjF8uHcmYnElPNX/6bSDLExdyq8C1esE3L/htDrVX1FZoH
         AXYzI3xTe7zuGavGbgTI3oizKeLmXLIwJWBkde1G8YHk+JW7wOZvb8wWJd7PaULBcWL8
         YFXlgdKY0c3RmAer+Ck+N5wRXNHoolFTPUpjA=
Received: by 10.216.89.202 with SMTP id c52mr2033142wef.215.1258230931111; 
	Sat, 14 Nov 2009 12:35:31 -0800 (PST)
In-Reply-To: <fabb9a1e0911141138r5279650ge57db2413e2321a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132885>

On Sat, Nov 14, 2009 at 8:38 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Sat, Nov 14, 2009 at 20:29, Victor Engmark <victor.engmark@gmail.com> wrote:
>> Do I need to run something after fetch to see them?
>
> Your working copy is probably not up to date anymore, try:
>
> $ git rebase git-svn

Thank you very much! That did the trick. Now to update svn2git.sh...

-- 
Victor Engmark
