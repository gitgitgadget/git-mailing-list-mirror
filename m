From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] ls-tree: add --full-tree option
Date: Fri, 26 Dec 2008 11:31:27 +0100
Message-ID: <9b18b3110812260231u8e81be6n44d3ccf43ac4438b@mail.gmail.com>
References: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org>
	 <200812260916.45401.j6t@kdbg.org>
	 <7vmyejpb6o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j6t@kdbg.org>, git@vger.kernel.org,
	"Deskin Miller" <deskinm@umich.edu>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 11:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG9zv-0000HZ-1D
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 11:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbYLZKba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 05:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753647AbYLZKba
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 05:31:30 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:40538 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbYLZKb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 05:31:29 -0500
Received: by qw-out-2122.google.com with SMTP id 3so2723555qwe.37
        for <git@vger.kernel.org>; Fri, 26 Dec 2008 02:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fZVpBBDh+04sq88+uDz3IMUJSybfuTjbbw07kg1QIs4=;
        b=DmObZTYp0S5RCL8q1LMa6E5GqcYvxQVmD5s3BrEwyvnRBwjTCJeTi7QKZSlJqzVcWw
         zsK3ek9uFGhhmrxJ1jx3XZOEk/OCWGQbwx0sC7QUnmw/6CSF3Nv6vD+tzbxvTkXWVxWk
         5joXrvw9Rd3VV5u3yp76Su9rwZ5JM8YcUcuHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oGFzHzh5SUVt+4NSj63USxg62s77kQn/EytVGgtERbt6DXE1D3ejT7SeTT82JE8K6F
         76bGzPpKejO+F+ydJqJ/b3aQsoY/5hm+ew84iANlbq1nLzHnOJMYYQUVPu/qti1OzGzw
         Qr1yszwaeXLmm9tOmwWV4+oHf62kHOU0C9eC0=
Received: by 10.214.181.21 with SMTP id d21mr9651797qaf.1.1230287487479;
        Fri, 26 Dec 2008 02:31:27 -0800 (PST)
Received: by 10.214.217.13 with HTTP; Fri, 26 Dec 2008 02:31:27 -0800 (PST)
In-Reply-To: <7vmyejpb6o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103931>

2008/12/26 Junio C Hamano <gitster@pobox.com>:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> On Freitag, 26. Dezember 2008, Junio C Hamano wrote:
>>> This new option makes the command operate on the full tree object,
>>> regardless of where in the work tree it is run from.  It also implies the
>>> behaviour that is triggered by the existing --full-name option.
>>
>> What's wrong with using 'git ls-tree ${rev}:'?
>>
>> Except that it does not work...
>
> Hmph... you seem to be describing the exact issue they discussed on #git,
> which triggered the patch in the message you are responding to.  I am not
> sure what to say to your "What's wrong with...".

AFAIK I started that discussion, and during it we also mentioned that
it would be very useful to be able to use git ls-files in non
recursive mode. As the advantage of using ls-tree, prior to your fix,
was that it is the only way to get a list of files for the current
working directory and only the current working directory.

Since you have fixed that bug what command does one us to get a list
of tracked files for the current working directory without recursing
into subdirectories? Can we have a switch on ls-files that disables
recursion? Please?

Cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
