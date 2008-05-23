From: =?UTF-8?B?RmxvcmlhbiBLw7ZiZXJsZQ==?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v2 04/24] Added path related constats to Constats
 class.
Date: Fri, 23 May 2008 17:46:42 +0200
Message-ID: <4836E6E2.20406@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-5-git-send-email-florianskarten@web.de> <20080512235431.GY29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 23 17:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzZUr-0006fy-BF
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 17:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbYEWPrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 11:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbYEWPrF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 11:47:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:47462 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbYEWPrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 11:47:03 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id E0815DE0E4DA;
	Fri, 23 May 2008 17:47:00 +0200 (CEST)
Received: from [84.150.81.80] (helo=[192.168.1.50])
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzZTw-0000Gc-00; Fri, 23 May 2008 17:47:00 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080512235431.GY29038@spearce.org>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX196YD5NuR0HiFb8PqqdTfcK4DH6aKUjKwZ25mLD
	YzkzhnaREFznUFXtq4lWRkk2BAyv3MH0q1KTH7SXk2aKKjGu7z
	iegGKOgEmol0pNMcjnOw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82717>

Shawn O. Pearce wrote:
> Florian Koeberle <florianskarten@web.de> wrote:
>> @@ -171,6 +171,26 @@ public final class Constants {
>>  	public static String REMOTES_PREFIX = "refs/remotes";
>>  
>>  	/**
>> +	 * The name of the repository directory in the project directory.
>> +	 */
>> +	public static final String REPOSITORY_DIRECTORY_NAME = ".git";
> 
> What is a project directory?
I will add a sentence describing what I meant with project directory here.



>> +	/**
>> +	 * Contains the name of the HEAD file in the repository directory.
>> +	 */
>> +	public static final String HEAD_FILE_NAME = "HEAD";
> 
> Isn't this already declared as just HEAD?  Lets not duplicate
> constants if we can avoid it, especially when they are in the
> same class.
>
current HEAD constant definition:
 > 	/** Special name for the "HEAD" symbolic-ref. */
 >	public static final String HEAD = "HEAD";
I didn't expect that this constant is a file name.

Looks like the constant is used in the same way I do, so It makes sense 
to use the existing HEAD constant.
