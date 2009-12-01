From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 01 Dec 2009 09:57:28 +0100
Message-ID: <4B14DA78.70906@syntevo.com>
References: <4B1168D4.5010902@syntevo.com> <200911282100.23000.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 09:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFOXq-0003D9-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 09:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbZLAI44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 03:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZLAI44
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 03:56:56 -0500
Received: from syntevo.com ([85.214.39.145]:54346 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816AbZLAI44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 03:56:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id A88BA37C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200911282100.23000.j6t@kdbg.org>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134181>

Johannes Sixt wrote:
> On Samstag, 28. November 2009, Thomas Singer wrote:
>> I've created a file with unicode characters in its name (using Java):
>>
>>  new File(dir, "\u3041\u3042\u3043\u3044").createNewFile();
>> ...
>> $ git add .
>> fatal: unable to stat '????': No such file or directory
>>
>> What should I do to make Git recognize these characters?
> 
> You cannot on a German Windows.
> 
> You can switch your Windows to Japanese (not the UI, just the codepage 
> aka "locale"; yes, that's possible, I have such a setup), but even then the 
> characters of the file name will be recorded in Shift-JIS encoding, not UTF-8 
> or Unicode. When you later switch back to German, these bytes will be 
> interpreted as cp850 or cp1252 text and displayed accordingly.

Who is interpreting the file names? Windows or Git or Java?

-- 
Tom
