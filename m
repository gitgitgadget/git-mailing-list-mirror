From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] resolve-undo.c: silence compiler complaints by casting
 void * to char *
Date: Tue, 02 Feb 2010 09:23:41 -0600
Message-ID: <97tOvtEqk8MiRaSVk9lJHcwIzHMJLo8v4hw8LEH-4JfIi16BeIKnLA@cipher.nrlssc.navy.mil>
References: <qzbyPiTgRGI0lsxvEmFa0WtwK5ko5snXQDNffxC66y9v0rlie5pcKzGT28WpzfQlFd0OvJNY_jo@cipher.nrlssc.navy.mil> <7vsk9kplla.fsf@alter.siamese.dyndns.org> <7vr5p4favs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKgr-0007cl-Dx
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab0BBP3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:29:12 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40488 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653Ab0BBP3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:29:10 -0500
Received: by mail.nrlssc.navy.mil id o12FNfLn021504; Tue, 2 Feb 2010 09:23:42 -0600
In-Reply-To: <7vr5p4favs.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Feb 2010 15:23:41.0745 (UTC) FILETIME=[B3952A10:01CAA41B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138724>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Thanks for catching this.
>>
>> In this particular case, I however suspect that it would be cleaner to
>> declare that the first parameter to resolve_undo_read() is a "char *"
>> (or even "const char *"), as we are dealing with NUL delimited list of
>> octal numbers and character strings.
> 
> It would look like this.

This works for me.

Thanks,
-brandon
