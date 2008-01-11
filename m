From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: CRLF problems with Git on Win32
Date: Fri, 11 Jan 2008 10:39:33 -0500
Message-ID: <eaa105840801110739w5b47c671n790f0dbdc9b0d2fd@mail.gmail.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	 <7vir24rtfp.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>
	 <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801091041570.31053@racer.site>
	 <Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se>
	 <alpine.LSU.1.00.0801101155140.31053@racer.site>
	 <Pine.LNX.4.64.0801101424580.11922@ds9.cixit.se>
	 <eaa105840801100631p6b95ed86j153d70244d474b03@mail.gmail.com>
	 <Pine.LNX.4.64.0801111409400.2497@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jan 11 16:40:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDLzV-0008Rk-6F
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 16:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943AbYAKPjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 10:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759826AbYAKPjg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 10:39:36 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:50403 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759304AbYAKPjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 10:39:35 -0500
Received: by mu-out-0910.google.com with SMTP id i10so903765mue.5
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 07:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=CQGPOUobQSO8mhDv/qY+NSR8a8AxcqEVvavFEPL9L9g=;
        b=PEH+TttxkjqetG0hsF26UWJVY60c+0oBqs1VqMK6TE0pb3YzTU3psrdwLpAnLEUHwXbMswVGoMFpx+IpzBRtpLjrSvYG0wY94BrpV7BtyxTK9wsCdWvU/7w9O24lB88j2jTuoSpKNdm5wxEaI0AJhg4Pizgia/rnyeqtWPpDuzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=CNa3neYWGNBmdHVZJbDluLasmbfR5Dx+oHivSOi+btWwu6a50vMVMT2AFkdaHiMVQ7CUa3bK7XOuruJbmzIt/8QSLxtuxwnmXeQ/QDDAX+H7xTiqCaeG0kCTHoUBvT2eByLcHGjB291WNLVrwGn2W7FJrS/p7PpKSZNn27vCOpQ=
Received: by 10.78.159.7 with SMTP id h7mr4024155hue.17.1200065973328;
        Fri, 11 Jan 2008 07:39:33 -0800 (PST)
Received: by 10.78.203.14 with HTTP; Fri, 11 Jan 2008 07:39:33 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801111409400.2497@ds9.cixit.se>
Content-Disposition: inline
X-Google-Sender-Auth: 7e8cdd085f7b5f1b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70168>

On Jan 11, 2008 8:12 AM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> > > I meant to say that any software that claims to be Windows software
> > > should handle, and produce, CRLF line breaks in text files.
>
> > Including zip/unzip?
>
> Yup (zip -l, unzip -a).

How is this any different from core.autocrlf? You get CRLF conversion
if you ask for it, and not if you don't.

Peter Harris
